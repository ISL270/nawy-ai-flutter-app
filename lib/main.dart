import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nawy_app/app/core/injection/injection.dart';
import 'package:nawy_app/app/core/theme/app_theme.dart';
import 'package:nawy_app/app/core/widgets/responsive_wrapper.dart';
import 'package:nawy_app/app/features/home/home_page.dart';
import 'package:nawy_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configure dependency injection and await async dependencies
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nawy Real Estate App',
      theme: AppTheme.lightTheme,
      home: const ResponsiveWrapper(child: HomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
