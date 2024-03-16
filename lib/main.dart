import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vega/screens/onboarding_screen.dart';
import 'package:vega/services/firebase_options.dart';
// Import your EdenOnboardingView

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  ); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          OnboardingProvider(), // Provide your OnboardingProvider
      child: MaterialApp(
        title: 'Your App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            EdenOnboardingView(), // Set EdenOnboardingView as the initial screen
      ),
    );
  }
}
