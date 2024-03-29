import 'package:daily_recipy/firebase_options.dart';
import 'package:daily_recipy/pages/splash.pages.dart';
import 'package:daily_recipy/viewModel/ads_provider.dart';
import 'package:daily_recipy/viewModel/app_auth_provider.dart';
import 'package:daily_recipy/viewModel/ingredients_provider.dart';
import 'package:daily_recipy/viewModel/recipes_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preference);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("error");
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppAuthprovider()),
    ChangeNotifierProvider(create: (_) => AdsProvider()),
    ChangeNotifierProvider(create: (_) => IngredientProvider()),
    ChangeNotifierProvider(create: (_) => RecipeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlayKit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Hellix',
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
