import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/screens/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: 'eShop',
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme().apply(
            bodyColor: Appcolors.textColor,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Appcolors.primaryColor),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
      designSize: const Size(390, 844),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Onboarding();
  }
}
