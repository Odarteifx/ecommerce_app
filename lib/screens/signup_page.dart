// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Auth/eshop_auth.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/screens/signin_page.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/eshop_typography.dart';

class EshopSignupPage extends ConsumerStatefulWidget {
  const EshopSignupPage({super.key});

  @override
  ConsumerState<EshopSignupPage> createState() => _EshopSignupPageState();
}

String name = '', email = '', password = '', confirmpassword = '';

class _EshopSignupPageState extends ConsumerState<EshopSignupPage> {
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

  registration() async {
    if (_formkey.currentState!.validate()) {
      name = _namecontroller.text.trim();
      email = _emailcontroller.text.trim();
      password = _passwordcontroller.text.trim();
      confirmpassword = _confirmpasswordcontroller.text.trim();
      if (password == confirmpassword &&
          _namecontroller.text.isNotEmpty &&
          _emailcontroller.text.isNotEmpty &&
          _passwordcontroller.text.isNotEmpty) {
        try {
          final userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          FirebaseAuth.instance.currentUser?.updateDisplayName(_namecontroller.text.trim());

          await FirebaseFirestore.instance
              .collection('User')
              .doc(userCredential.user!.uid)
              .set({
            'name': _namecontroller.text.trim(),
            'email': email,
            'id': userCredential.user!.uid,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Center(child: Text('Account Successfully Created'))),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const EshopHomePage(),
            ),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'Your password is too simple. Try adding more characters, numbers, or symbols.')));
          } else if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'Account already exists. Try logging in or use a different email.')));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${e.message}')));
          } // ... (error handling remains the same)
        } catch (e) {
          // Handle any other errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAccepted = ref.watch(termsProvdier);

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
                function: isAccepted
                    ? registration
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Accept Terms of Service and Privacy Policy')));
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
                      iconUrl: EshopAssets.googlelogo,
                      function: () {
                        AuthMethods().signInWithGoogle(context);
                      }),
                  SigninIcon(iconUrl: EshopAssets.applelogo, function: () {})
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
                    child: content,
                  )
                : content));
  }
}
