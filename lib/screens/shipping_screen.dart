import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:ecommerce_app/controllers/address_controller.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/controllers/orders_controller.dart';
import 'package:ecommerce_app/models/order_models/order_item.dart';
import 'package:ecommerce_app/models/order_models/orders_model.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/colors.dart';
import '../constants/eshop_typography.dart';

import '../utils/utils.dart';
import 'payment_page.dart';

/// Provider to track if user wants to add new address
final showNewAddressFormProvider = StateProvider<bool>((ref) => false);

class ShippingScreen extends ConsumerWidget {
  final double amount;
  final List<OrderItem> orderItems;
  const ShippingScreen({
    super.key,
    required this.amount,
    required this.orderItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedAddresses = ref.watch(addressStreamProvider);
    final selectedAddress = ref.watch(selectedAddressProvider);
    final showNewAddressForm = ref.watch(showNewAddressFormProvider);

    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Appcolors.backgroundColor,
          title: Text(
            'Shipping Address',
            style: GoogleFonts.roboto(
              fontSize: 18.sp,
              fontWeight: EshopFontweight.medium,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: FilledButton(
              onPressed: () async {
                // Check if an address is selected or new form is filled
                if (selectedAddress == null && !showNewAddressForm) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select or add a shipping address'),
                    ),
                  );
                  return;
                }

                final double amountInUSD = (amount * 100).toDouble();
                final ghsAmount = await CurrencyConverter.convert(
                  amount: amountInUSD,
                  from: Currency.usd,
                  to: Currency.ghs,
                );
                final amountNew = ghsAmount?.toStringAsFixed(0);
                final amountInCedis = double.parse(amountNew!);
                final reference = Utils.uniqueRefenece();
                debugPrint(amountInCedis.toString());

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    reference: reference,
                    amount: amountInCedis,
                    email: FirebaseAuth.instance.currentUser!.email!,
                    currency: 'GHS',
                    onSuccessfulTransaction: (data) {
                      debugPrint('Transaction successful');

                      final order = Orders(
                        orderId: 'order-${Utils.uniqueRefenece()}',
                        email: FirebaseAuth.instance.currentUser!.email!,
                        total: amount,
                        items: orderItems,
                        status: 'pending',
                        createdAt: DateTime.now(),
                        transactionRef: reference,
                      );
                      ref
                          .read(ordersControllerProvider.notifier)
                          .addOrder(order);
                      debugPrint('Order added');

                      ref.read(cartControllerProvider.notifier).clearCart();

                      // Clear selected address
                      ref.read(selectedAddressProvider.notifier).state = null;
                      ref.read(showNewAddressFormProvider.notifier).state = false;

                      // Show success message and navigate to home
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Order placed successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Navigate to home and clear navigation stack
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const EshopHomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    onFailedTransaction: (data) {
                      debugPrint('Transaction failed');

                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment was not completed. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );

                      // Navigate back to home (cart is preserved for retry)
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const EshopHomePage(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ));
              },
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp)),
                  backgroundColor: Appcolors.bottomNavActive),
              child: Text(
                'Proceed to Payment',
                style:
                    GoogleFonts.roboto(fontSize: EshopTypography.onboadingbody),
              )),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Saved Addresses Section
                        Text(
                          'Saved Addresses',
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: EshopFontweight.semibold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        savedAddresses.when(
                          data: (addresses) {
                            if (addresses.isEmpty) {
                              return Container(
                                padding: EdgeInsets.all(15.sp),
                                decoration: BoxDecoration(
                                  color: Appcolors.widgetcolor,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                  child: Text(
                                    'No saved addresses',
                                    style: GoogleFonts.roboto(
                                      color: Appcolors.subtextColor,
                                      fontSize: EshopTypography.subtext,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children: addresses.map((address) {
                                final isSelected = selectedAddress?.addressId ==
                                    address.addressId;
                                return GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(selectedAddressProvider.notifier)
                                        .state = address;
                                    ref
                                        .read(
                                            showNewAddressFormProvider.notifier)
                                        .state = false;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    padding: EdgeInsets.all(12.sp),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Appcolors.primaryColor
                                              .withOpacity(0.1)
                                          : Appcolors.widgetcolor,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      border: Border.all(
                                        color: isSelected
                                            ? Appcolors.primaryColor
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: address.addressId ?? '',
                                          groupValue:
                                              selectedAddress?.addressId ?? '',
                                          onChanged: (value) {
                                            ref
                                                .read(selectedAddressProvider
                                                    .notifier)
                                                .state = address;
                                            ref
                                                .read(showNewAddressFormProvider
                                                    .notifier)
                                                .state = false;
                                          },
                                          activeColor: Appcolors.primaryColor,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    address.fullName,
                                                    style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          EshopFontweight
                                                              .medium,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    address.phoneNumber,
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 12.sp,
                                                      color: Appcolors
                                                          .subtextColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                address.addressLine,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 13.sp,
                                                  color: Appcolors.subtextColor,
                                                ),
                                              ),
                                              Text(
                                                '${address.city}, ${address.state ?? ''} ${address.country}',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 13.sp,
                                                  color: Appcolors.subtextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (isSelected)
                                          Icon(
                                            Iconsax.tick_circle5,
                                            color: Appcolors.primaryColor,
                                            size: 20.sp,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, stack) => Center(
                            child: Text('Error loading addresses'),
                          ),
                        ),
                        SizedBox(height: 15.h),

                        // Add New Address Button/Section
                        if (!showNewAddressForm)
                          GestureDetector(
                            onTap: () {
                              ref
                                  .read(showNewAddressFormProvider.notifier)
                                  .state = true;
                              ref.read(selectedAddressProvider.notifier).state =
                                  null;
                            },
                            child: Container(
                              padding: EdgeInsets.all(15.sp),
                              decoration: BoxDecoration(
                                color: Appcolors.widgetcolor,
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                  color: Appcolors.primaryColor,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.add,
                                    color: Appcolors.primaryColor,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Add New Address',
                                    style: GoogleFonts.roboto(
                                      color: Appcolors.primaryColor,
                                      fontWeight: EshopFontweight.medium,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // New Address Form
                        if (showNewAddressForm) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'New Address',
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: EshopFontweight.semibold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(showNewAddressFormProvider.notifier)
                                      .state = false;
                                },
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.roboto(
                                    color: Appcolors.promptColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          ShippingForm(false),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50.h,
                color: Appcolors.subtextColor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:',
                        style: GoogleFonts.roboto(
                            fontSize: EshopTypography.onboadingbody,
                            fontWeight: EshopFontweight.regular,
                            color: Appcolors.textColor)),
                    Expanded(child: SizedBox()),
                    Text(
                      '\$${amount.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(
                          fontSize: EshopTypography.onboadingbody,
                          fontWeight: EshopFontweight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
