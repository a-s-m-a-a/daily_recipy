import 'package:daily_recipy/reusable_widgets/reusableTextFormField.dart';
import 'package:daily_recipy/reusable_widgets/reusable_widgits.dart';
import 'package:daily_recipy/utils/colors.utils.dart';
import 'package:daily_recipy/utils/images.utils.dart';
import 'package:daily_recipy/viewModel/app_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  GlobalKey<FormState>? formKey;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    Provider.of<AppAuthprovider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthprovider>(
        builder: (context, authProvider, child) => Scaffold(
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
                                  key: formKey,
                                  child: Column(children: [
                                    ReusableTextFormField(
                                        controller:
                                            authProvider.emailController!,
                                        icon: Icons.email,
                                        isPasswordType: false,
                                        lableText: "Email Address",
                                        validateText: "Enter Valid Email"),
                                    ReusableTextFormField(
                                        controller:
                                            authProvider.passwordController!,
                                        icon: Icons.password,
                                        isPasswordType: true,
                                        lableText: "Password",
                                        validateText: "Enter Valid password"),
                                  ]),
                                ),
                                richText(1, ["Forget Password?"],
                                    [hexStringToColor("#12819D")], [() {}]),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child:
                                      reusableButton(width, 50, "Sign In", () {
                                    authProvider.signIn(context, formKey);
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
              //if keybourd pushed then delete floating action button
              floatingActionButton:
                  (MediaQuery.of(context).viewInsets.bottom == 0)
                      ? richText(2, [
                          "Don't have an account? ",
                          "Register"
                        ], [
                          Colors.white,
                          hexStringToColor("#F45B00")
                        ], [
                          () {},
                          () {
                            authProvider.openRegisterpage(context, formKey);
                          }
                        ])
                      : null,
            ));
  }
}
