import 'package:daily_recipy/pages/splash.pages.dart';
import 'package:daily_recipy/utils/colors.utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Padding reusableTextField(
    bool isPasswordType, IconData icon, String lableText) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextField(
      obscureText: isPasswordType,
      enableSuggestions: isPasswordType,
      autocorrect: isPasswordType,
      cursorColor: Colors.black,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        suffixIcon:
            isPasswordType ? const Icon(Icons.visibility_off) : const Icon(Icons.edit),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        labelText: lableText,
        labelStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    ),
  );
}

Container reusableButton(
    double width, double height, String text, Function onTap) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return hexStringToColor("#F45B00");
          }
          return Colors.transparent;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black;
          }
          return Colors.white;
        }),
        elevation: const MaterialStatePropertyAll(0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 25),
      ),
    ),
  );
}

RichText richText(
    int num, List<String> text, List<Color> colors, List<Function> function) {
  return RichText(
      text: TextSpan(children: <TextSpan>[
    for (int i = 0; i < num; i++)
      TextSpan(
          text: text[i],
          style: TextStyle(
            color: colors[i],
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = function[i] as GestureTapCallback?),
  ]));
}

Function splashFunction(var context, Widget pushToPage, bool isLogIn) {
  fun() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashPageState.keyLogin, isLogIn);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => pushToPage));
  }

  return fun;
}


