import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/controllers/address_controller.dart';
import 'package:ecommerce_app/screens/new_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/eshop_typography.dart';

class AddedAddressScreen extends ConsumerWidget {
  const AddedAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shippingAddress = ref.watch(addressControllerProvider);
    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Appcolors.backgroundColor,
          title: const Text('Saved Address'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewAddress(),
                    ));
              },
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp)),
                  backgroundColor: Appcolors.bottomNavActive),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.add,
                      size: 20.sp, color: Appcolors.backgroundColor),
                  SizedBox(width: 10.sp),
                  Text(
                    'Add New Address',
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.onboadingbody),
                  ),
                ],
              )),
        ),
        body: Scaffold(
            backgroundColor: Appcolors.backgroundColor,
            body: shippingAddress.isEmpty
                ? Center(
                    child: Text('No Saved Address',
                        style: GoogleFonts.roboto(
                            color: Appcolors.iconColor,
                            fontSize: EshopTypography.onboadingbody)),
                  )
                : ListView.builder(
                    itemCount: shippingAddress.length,
                    itemBuilder: (context, index) {
                      final savedAddress = shippingAddress[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              savedAddress.fullName,
                              style: GoogleFonts.roboto(
                                  fontWeight: EshopFontweight.medium),
                            ),
                            SizedBox(width: 5.sp),
                            Text(
                              savedAddress.phoneNumber,
                              style: GoogleFonts.roboto(
                                  fontSize: EshopTypography.homepagecategories),
                            )
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(savedAddress.addressLine),
                            Text(
                                '${savedAddress.city} ${savedAddress.country} ${savedAddress.state}')
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 200,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.sp),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: FilledButton(
                                                    onPressed: () {},
                                                    child: Text('Edit Address'),
                                                    style: FilledButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.sp)),
                                                        backgroundColor: Appcolors
                                                            .bottomNavActive))),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: FilledButton(
                                                    style: FilledButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Appcolors
                                                                    .primaryColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.sp)),
                                                        backgroundColor: Appcolors
                                                            .backgroundColor),
                                                    onPressed: () {
                                                      debugPrint(savedAddress
                                                          .addressId);
                                                      ref
                                                          .read(
                                                              addressControllerProvider
                                                                  .notifier)
                                                          .deleteShippingAddress(
                                                              savedAddress
                                                                  .addressId!);
                                                    },
                                                    child: Text(
                                                      'Delete Address',
                                                      style: GoogleFonts.roboto(
                                                          color: Appcolors
                                                              .bottomNavActive),
                                                    ))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(Iconsax.edit),
                        ),
                      );
                    },
                  )));
  }
}
