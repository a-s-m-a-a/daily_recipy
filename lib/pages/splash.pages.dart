import 'package:daily_recipy/pages/home.pages.dart';
import 'package:daily_recipy/pages/signin_or_signup.pages.dart';
import 'package:daily_recipy/utils/images.utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initSplash();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImagesPath.background),
          fit: BoxFit.cover,
        )),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Image(image: AssetImage(ImagesPath.logo)),
            ),
            const CircularProgressIndicator(),
          ],
        )),
      ),
    ));
  }

  void initSplash() async {
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      if (GetIt.I.get<SharedPreferences>().getBool('isLogin') ?? false) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SigniniOrSignup()));
      }
    });
  }
}
