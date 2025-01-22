import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/controllers/address_controller.dart';
import 'package:ecommerce_app/services/address_services.dart';
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
        body: Scaffold(
            body: shippingAddress.isEmpty
                ? Center(
                  child: Text('No Saved Address',
                      style: GoogleFonts.roboto(
                          fontSize: EshopTypography.onboadingbody)),
                )
                : ListView.builder(
                     itemCount: shippingAddress.length,
                     itemBuilder: (context, index) {
                     final savedAddress = shippingAddress[index];
                     return  ListTile(
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
                                   Text('${savedAddress.city} ${savedAddress.country} ${savedAddress.state}')
                                 ],
                               ),
                               trailing: IconButton(
                                 onPressed: () {},
                                 icon: Icon(Iconsax.edit),
                               ),
                             );
                   },)));
  }
}
