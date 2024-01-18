// ignore_for_file: use_build_context_synchronously

import 'package:daily_recipy/pages/home.pages.dart';
import 'package:daily_recipy/pages/login.pages.dart';
import 'package:daily_recipy/pages/register.pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuthprovider extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  bool obsecuretext = false;

  void providerInit() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  void providerDespose() {
    formKey = null;
    emailController = null;
    passwordController = null;
    nameController = null;
    obsecuretext = false;
  }

  void openRegisterpage(BuildContext context) {
    providerDespose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  void openLoginpage(BuildContext context) {
    providerDespose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);
        if (credentials.user != null) {
          await credentials.user?.updateDisplayName(nameController!.text);
          providerDespose();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        }
      }
    } catch (e) {
      print("error with signUp");
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text)
            .then((value) => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage())))
            .onError((error, stackTrace) => const AlertDialog(
                  title: Text("wrong email or password"),
                ));
      }
    } catch (e) {
      print("error with signIn");
    }
  }

  void toggelObsecure() {
    obsecuretext = !obsecuretext;
    notifyListeners();
  }
}
