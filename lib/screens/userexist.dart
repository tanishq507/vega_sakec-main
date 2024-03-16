import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vega/screens/main_screen.dart';
import 'package:vega/sponers/home_screen.dart'; // Import the home screen or the screen you want to navigate to
import 'package:vega/screens/login_screen.dart';
import 'package:vega/widgets/custom_text_button.dart';
import 'package:vega/widgets/primary_button.dart';

class UserExist extends StatefulWidget {
  const UserExist({Key? key}) : super(key: key);

  @override
  State<UserExist> createState() => _UserExistState();
}

class _UserExistState extends State<UserExist> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signInUser() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Check if the user exists in the database (you need to implement this logic)
      if (userCredential.user != null) {
        // User signed in successfully, navigate to home screen
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainScreen()), // Replace HomeScreen with the screen you want to navigate to
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  "Already an User ? Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Center(
                child: Text(
                  'Login for acessing your  account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              AuthField(
                controller: _emailController,
                hintText: 'Enter Email',
              ),
              const SizedBox(height: 30),
              AuthField(
                controller: _passwordController,
                hintText: 'Enter Password',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  onPressed: () {},
                  text: 'Forget Password?',
                ),
              ),
              const SizedBox(height: 20),
              ShakeWidget(
                key: _shakeKey,
                shakeOffset: 10.0,
                shakeDuration: const Duration(milliseconds: 500),
                child: PrimaryButton(
                  onTap: signInUser,
                  text: 'Log In',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              const DividerWithText(),
              const SizedBox(height: 20),
              CustomSocialButton(
                onTap: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => LogInView()),
                  );
                },
                icon: AppAssets.kFaceBook,
                text: 'Sign up',
                margin: 0,
              ),
              const SizedBox(height: 20),
              CustomSocialButton(
                onTap: () {},
                icon: AppAssets.kGoogle,
                text: 'Join using Google',
                margin: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Rest of your code remains the same...
