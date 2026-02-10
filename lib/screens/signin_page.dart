// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_app/Auth/eshop_auth.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/screens/signup_page.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EshopSignInPage extends StatefulWidget {
  const EshopSignInPage({super.key});

  @override
  State<EshopSignInPage> createState() => _EshopSignInPageState();
}

class _EshopSignInPageState extends State<EshopSignInPage> {
  late final TextEditingController _emailcontroller;
  late final TextEditingController _passwordcontroller;

  final _formkey = GlobalKey<FormState>();
  
  // Loading states
  bool _isEmailLoading = false;
  bool _isGoogleLoading = false;

  userLogin() async {
    setState(() => _isEmailLoading = true);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EshopHomePage(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect password. Please try again')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.message}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => _isEmailLoading = false);
    }
  }

  googleLogin() async {
    setState(() => _isGoogleLoading = true);
    try {
      await AuthMethods().signInWithGoogle(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Google sign-in failed: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

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
                      hintText: 'Password',
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
                _isEmailLoading
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.sp)),
                                backgroundColor: Appcolors.primaryColor),
                            onPressed: null,
                            child: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      )
                    : MajorButton(
                        buttonText: 'Log In',
                        function: () {
                          if (_formkey.currentState!.validate()) {
                            email = _emailcontroller.text.trim();
                            password = _passwordcontroller.text.trim();
                            userLogin();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill in all fields'),
                              ),
                            );
                          }
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
                      _isGoogleLoading
                          ? SizedBox(
                              height: 50.h,
                              width: 150.w,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Appcolors.widgetcolor,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Appcolors.iconColor, width: 1),
                                        borderRadius: BorderRadius.circular(15))),
                                onPressed: null,
                                child: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            )
                          : SigninIcon(
                              iconUrl: EshopAssets.googlelogo,
                              function: googleLogin),
                      SigninIcon(
                          iconUrl: EshopAssets.applelogo,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EshopSignupPage(),
                          ));
                    })
              ],
            ),
          ),
        )));
  }
}
