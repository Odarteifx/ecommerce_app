import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/colors.dart';

class OrderTrack extends StatelessWidget {
  final String date;
  final String title;
  final String location;
  final int index;
  final bool isActive;
  final String status;
  final bool hasDropdown;
  final bool isExpanded;
  final VoidCallback? onToggleExpand;

  const OrderTrack(
      {super.key,
      required this.date,
      required this.title,
      required this.location,
      required this.index,
      this.isActive = false,
      required this.status,
      this.hasDropdown = false,
      this.isExpanded = false,
      this.onToggleExpand});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.sp,
                  color: index == 1
                      ? const Color(0xFFEFE052)
                      : index == 2
                          ? Colors.grey
                          : Color(0xFFFCBA88),
                ),
                color: index == 1
                    ? const Color(0xFFF5E76D)
                    : index == 2
                        ? Colors.black
                        : const Color(0xFFFFD187),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                index == 1
                    ? Iconsax.box_add
                    : index == 2
                        ? Iconsax.tick_circle
                        : Iconsax.truck_fast,
                size: 22.sp,
                color: index == 1
                    ? Colors.black
                    : index == 2
                        ? Appcolors.backgroundColor
                        : Colors.black,
              ),
            ),
            if (index == 2)
              Text('')
            else
              StatusLine(
                index: index,
                status: status,
              ),
            if ((index == 3) && hasDropdown && isExpanded)
              Column(
                children: [
                  StatusPoint(),
                  StatusLine(
                    index: index,
                    status: status,
                  ),
                  StatusPoint(),
                  StatusLine(
                    index: index,
                    status: status,
                  ),
                  StatusPoint(),
                  StatusLine(
                    index: index,
                    status: status,
                  ),
                  StatusPoint(),
                  StatusLine(
                    index: index,
                    status: status,
                  ),
                ],
              ),
          ],
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: EshopFontweight.medium,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        if (hasDropdown)
                          GestureDetector(
                            onTap: onToggleExpand,
                            child: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 20.sp,
                            ),
                          ),
                        Spacer(),
                        if (index != 3)
                          Text(
                            date,
                          )
                      ],
                    ),
                  )
                ],
              ),
              Text(
                location,
                style: GoogleFonts.roboto(
                    fontSize: EshopTypography.termsfont,
                    fontWeight: EshopFontweight.medium,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 22.h,
              ),
              if (hasDropdown && isExpanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.h,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Delivered',
                        ),
                        Spacer(),
                        status == 'delivered' || status == 'processing'
                            ? Text(
                                date,
                              )
                            : Text('')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Arrived at the sorting center',
                        ),
                        Spacer(),
                        status == 'delivered'
                            ? Text(
                                date,
                              )
                            : Text('')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '\$location',
                        ),
                        Spacer(),
                        status == 'delivered'
                            ? Text(
                                date,
                              )
                            : Text('')
                      ],
                    ),
                    Text(
                      "\$city",
                    )
                  ],
                )
            ],
          ),
        )
      ],
    );
  }
}

class StatusPoint extends StatelessWidget {
  const StatusPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: Colors.orange,
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
          ),
        )
      ],
    );
  }
}

class StatusLine extends StatelessWidget {
  const StatusLine({super.key, required this.index, required this.status});

  final int index;
  final String status;

  @override
  Widget build(BuildContext context) {
    bool processing = status == 'processing';
    bool delivered = status == 'delivered';
    bool pending = status == 'pending';

    Color getColor() {
      if (pending && index == 1) {
        return const Color(0x393C3C3C);
      } else if (processing) {
        if (index == 1) {
          return index == 1
              ? Color(0xffecd85c)
              : index == 2
                  ? Color(0xFFFCBA88)
                  : Colors.transparent;
        } else if (index == 2) {
          return index == 1
              ? Color(0xffecd85c)
              : index == 2
                  ? Color(0xFFFCBA88)
                  : Colors.transparent;
        }
      } else if (delivered) {
        return index == 1
            ? Color(0xffecd85c)
            : index == 3
                ? Color(0xFFFCBA88)
                : Colors.transparent;
      }
      return const Color(0x393C3C3C);
    }

    return Container(width: 2.w, height: 25.h, color: getColor());
  }
}
