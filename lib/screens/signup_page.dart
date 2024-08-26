import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/screens/signin_page.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/eshop_typography.dart';

class EshopSignupPage extends StatefulWidget {
  const EshopSignupPage({super.key});

  @override
  State<EshopSignupPage> createState() => _EshopSignupPageState();
}

class _EshopSignupPageState extends State<EshopSignupPage> {
  final _formkey = GlobalKey<FormState>();

  late final TextEditingController _namecontroller;
  late final TextEditingController _emailcontroller;
  late final TextEditingController _passwordcontroller;
  late final TextEditingController _confirmpasswordcontroller;

  @override
  void initState() {
    _namecontroller = TextEditingController();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    _confirmpasswordcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final isSmaller = screenheight <= 667;

    Widget content = Center(
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const EshopLogo(
              logoColor: Appcolors.primaryColor,
            ),
            SizedBox(
              height: 10.h,
            ),
            const PageHeading(title: 'Get Started'),
            SizedBox(
              height: 5.h,
            ),
            const SubText(subtext: 'Enter your details below'),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: NameTextField(controller: _namecontroller),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: EmailTextField(controller: _emailcontroller)),
            SizedBox(
              height: 10.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: PasswordTextField(
                  controller: _passwordcontroller,
                  hintText: 'Password',
                )),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PasswordTextField(
                controller: _confirmpasswordcontroller,
                hintText: 'Confirm password',
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 15.h,
            ),
            MajorButton(
                buttonText: 'Sign Up',
                function: () {
                  if (_formkey.currentState!.validate()) {
                    //email = _emailcontroller;
                    // password = _passwordcontroller;
                  }
                  //login
                }),
            const EshopTermsConditions(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Expanded(child: Divider()),
                  SizedBox(
                    width: 14.h,
                  ),
                  Text(
                    'Or continue with',
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.subtext,
                        fontWeight: EshopFontweight.medium),
                  ),
                  SizedBox(
                    width: 14.h,
                  ),
                  const Expanded(child: Divider())
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SigninIcon(
                      iconUrl: 'assets/icons/google.png', function: () {}),
                  SigninIcon(
                      iconUrl: 'assets/icons/apple-logo.png', function: () {})
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            UnderNote(
                questionText: 'Already have an account? ',
                actionText: 'Log In',
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EshopSignInPage(),
                      ));
                })
          ],
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        body: SigninStack(
            pagecontent: isSmaller
                ? SingleChildScrollView(
                  clipBehavior: Clip.none,
                    child: content,
                  )
                : content));
  }
}
