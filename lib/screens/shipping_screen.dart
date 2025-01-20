import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:ecommerce_app/screens/signup_page.dart';
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
  const ShippingScreen({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
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
                debugPrint(amountInCedis.toString());

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    reference: Utils.uniqueRefenece(),
                    amount: amountInCedis,
                    email: FirebaseAuth.instance.currentUser!.email!,
                    currency: 'GHS',
                    onSuccessfulTransaction: (data) {
                      debugPrint('Transaction successful');
                    },
                    onFailedTransaction: (data) {
                      debugPrint('Transaction failed');
                    },
                  ),
                ));
              },
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.sp)),
                  backgroundColor: Appcolors.bottomNavActive),
              child: Text(
                'Proceed to Payment',
                style: GoogleFonts.roboto(
                    fontWeight: EshopFontweight.bold,
                    fontSize: EshopTypography.onboadingbody),
              )),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                spacing: 5.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Contact Information',
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: EshopFontweight.bold,
                          color: Appcolors.textColor)),
                  TextField(
              
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: userEmail,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.iconColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text('Shipping Address',
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: EshopFontweight.bold,
                          color: Appcolors.textColor)),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Full Name',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Address',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'City',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'State',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Country',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox(height: 20)),
            Container(
              height: 50.h,
              color: Appcolors.subtextColor,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Summary:',
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
        ));
  }
}
