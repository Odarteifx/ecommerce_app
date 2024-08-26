import 'dart:math';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/eshop_assets.dart';
import '../constants/eshop_typography.dart';

//Onboarding and pageview Images
class OnboardingAsset extends StatelessWidget {
  final String imagePath;
  const OnboardingAsset({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 390.w,
      height: 390.h,
    );
  }
}

//Eshop logo
class EshopLogo extends StatelessWidget {
  const EshopLogo({super.key, required this.logoColor});

  final Color logoColor;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          'eSh',
          style: GoogleFonts.roboto(
            fontStyle: FontStyle.italic,
            fontSize: EshopTypography.heading1,
            letterSpacing: EshopTypography.heading1 * -0.05,
            color: logoColor,
            fontWeight: EshopFontweight.semibold,
          ),
        ),
        Text(
          'op',
          style: GoogleFonts.roboto(
            fontStyle: FontStyle.italic,
            fontSize: EshopTypography.heading1,
            letterSpacing: EshopTypography.heading1 * -0.05,
            color: logoColor,
            fontWeight: EshopFontweight.semibold,
            decoration: TextDecoration.underline,
            decorationColor: logoColor,
            decorationThickness: 1.5.sp,
          ),
        ),
      ],
    );
  }
}

// MajorButttons - Get Started, Signin, Signup btns
class MajorButton extends StatelessWidget {
  const MajorButton(
      {super.key, required this.buttonText, required this.function});

  final String buttonText;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: FilledButton(
          style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: Appcolors.primaryColor),
          onPressed: function,
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(
                fontSize: EshopTypography.subtext,
                fontWeight: EshopFontweight.medium),
          ),
        ),
      ),
    );
  }
}

//Signin background stack
class SigninStack extends StatelessWidget {
  const SigninStack({super.key, required this.pagecontent});

  final Widget pagecontent;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -80.h,
            left: -90.w,
            child: Transform.rotate(
                angle: pi / -22.3, child: Image.asset(EshopAssets.signinup))),
        Positioned(
            top: 744.h,
            left: 257.w,
            child: Image.asset(EshopAssets.signindown)),
        SafeArea(child: pagecontent)
      ],
    );
  }
}

//Page headding text
class PageHeading extends StatelessWidget {
  const PageHeading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: EshopTypography.heading2,
        fontWeight: EshopFontweight.semibold,
      ),
    );
  }
}

//subtext
class SubText extends StatelessWidget {
  const SubText({super.key, required this.subtext});

  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtext,
      style: GoogleFonts.roboto(
          fontSize: EshopTypography.subtext,
          fontWeight: EshopFontweight.regular,
          color: Appcolors.subtextColor),
    );
  }
}

//note beneath login/singup page
class UnderNote extends StatelessWidget {
  const UnderNote(
      {super.key,
      required this.questionText,
      required this.actionText,
      required this.function});

  final String questionText;
  final String actionText;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          questionText,
          style: GoogleFonts.roboto(
              fontSize: EshopTypography.subtext,
              fontWeight: EshopFontweight.regular,
              color: Appcolors.subtextColor),
        ),
        InkWell(
          onTap: function,
          child: Text(
            actionText,
            style: GoogleFonts.roboto(
                fontSize: EshopTypography.subtext,
                fontWeight: EshopFontweight.medium,
                color: Appcolors.primaryColor),
          ),
        )
      ],
    );
  }
}

// App signin btns
class SigninIcon extends StatelessWidget {
  const SigninIcon({super.key, required this.iconUrl, required this.function});
  final String iconUrl;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50.h,
        width: 150.w,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Appcolors.widgetcolor,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Appcolors.iconColor, width: 1),
                  borderRadius: BorderRadius.circular(15))),
          onPressed: function,
          child: Image.asset(
            iconUrl,
            height: 25.h,
          ),
        ));
  }
}

//email textfield
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your email address';
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Enter email address',
          hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Appcolors.iconColor))),
    );
  }
}

// Password textfield
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

bool _hidepassword = true;

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a valid password';
        } else {
          return null;
        }
      },
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _hidepassword,
      obscuringCharacter: '*',
      decoration: InputDecoration(
          hintText: 'Password',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hidepassword = !_hidepassword;
              });
            },
            icon: Icon(
              _hidepassword ? Iconsax.eye : Iconsax.eye_slash,
              color: Appcolors.subtextColor,
            ),
          ),
          hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Appcolors.iconColor))),
    );
  }
}
