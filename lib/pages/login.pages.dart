import 'package:daily_recipy/pages/home.pages.dart';
import 'package:daily_recipy/pages/register.pages.dart';
import 'package:daily_recipy/reusable_widgets/reusable_widgits.dart';
import 'package:daily_recipy/utils/colors.utils.dart';
import 'package:daily_recipy/utils/images.utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesPath.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      children: [
                        Image(image: AssetImage(ImagesPath.logo)),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(children: [
                            reusableTextFormField(
                                false,
                                Icons.email,
                                "Email Address",
                                "Enter Valid Email",
                                _emailController),
                            reusableTextFormField(
                                true,
                                Icons.password,
                                "Password",
                                "Enter your password",
                                _passwordController),
                          ]),
                        ),
                        richText(1, ["Forget Password?"],
                            [hexStringToColor("#12819D")], [() {}]),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: reusableButton(width, 50, "Sign In", () {
                            if ((_formKey.currentState?.validate() ?? false)) {
                              GetIt.I
                                  .get<SharedPreferences>()
                                  .setBool('isLogin', true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: richText(2, [
        "Don't have an account? ",
        "Register"
      ], [
        Colors.white,
        hexStringToColor("#F45B00")
      ], [
        () {},
        () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterPage()));
        }
      ]),
    );
  }
}
