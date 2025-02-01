import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/controllers/orders_controller.dart';
import 'package:ecommerce_app/models/order_models/order_item.dart';
import 'package:ecommerce_app/models/order_models/orders_model.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../constants/eshop_typography.dart';

import '../utils/utils.dart';
import 'payment_page.dart';

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
    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Appcolors.backgroundColor,
        ),
        bottomNavigationBar: BottomAppBar(
          child: FilledButton(
              onPressed: () async {
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
                    reference:reference,
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
                          ref.read(ordersControllerProvider.notifier).addOrder(order);
                          debugPrint('Order added');

                          ref.read(cartControllerProvider.notifier).clearCart();
                    },
                    onFailedTransaction: (data) {
                      debugPrint('Transaction failed');
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
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: ShippingForm(
                      false,
                    )),
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
