import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> signIn(String email, String password) async {
    try {
      // Call Firebase sign-in method
      // await _auth.signInWithEmailAndPassword(email: email, password: password);
      _isLoggedIn = true;
      notifyListeners();
    } catch (error) {
      // Handle sign-in errors
      print(error.toString());
    }
  }

  Future<void> signOut() async {
    try {
      // Call Firebase sign-out method
      // await _auth.signOut();
      _isLoggedIn = false;
      notifyListeners();
    } catch (error) {
      // Handle sign-out errors
      print(error.toString());
    }
  }
}
