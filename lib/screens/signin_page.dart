import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EshopSignInPage extends StatefulWidget {
  const EshopSignInPage({super.key});

  @override
  State<EshopSignInPage> createState() => _EshopSignInPageState();
}

class _EshopSignInPageState extends State<EshopSignInPage> {
  late final TextEditingController _emailcontroller;
  late final TextEditingController _passwordcontroller;

  final _formkey = GlobalKey<FormState>();

  late final email;
  late final password;

  @override
  void initState() {
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        body: SigninStack(
            pagecontent: Center(
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
                  height: 20.h,
                ),
                const PageHeading(title: 'Welcome Back!'),
                SizedBox(
                  height: 5.h,
                ),
                const SubText(subtext: 'Enter your details below'),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: EmailTextField(controller: _emailcontroller)),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: PasswordTextField(
                      controller: _passwordcontroller,
                    )),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      InkWell(
                        child: Text(
                          'Forget password?',
                          style: GoogleFonts.roboto(
                              color: Appcolors.subtextColor,
                              fontSize: EshopTypography.subtext,
                              fontWeight: EshopFontweight.regular),
                        ),
                        onTap: () {
                          //forgot password
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MajorButton(
                    buttonText: 'Log In',
                    function: () {
                      if (_formkey.currentState!.validate()) {
                        email = _emailcontroller;
                        password = _passwordcontroller;
                      }
                      //login
                    }),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Expanded(child: Divider()),
                      SizedBox(
                        width: 14.h,
                      ),
                      Text(
                        'Or login via',
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
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SigninIcon(
                          iconUrl: 'assets/icons/google.png', function: () {}),
                      SigninIcon(
                          iconUrl: 'assets/icons/apple-logo.png',
                          function: () {})
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                UnderNote(
                    questionText: 'Don’t have an account? ',
                    actionText: 'Sign up',
                    function: () {
                      //Navigate to signup Page
                    })
              ],
            ),
          ),
        )));
  }
}
