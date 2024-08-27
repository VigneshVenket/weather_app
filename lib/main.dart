import 'package:flutter/material.dart';
import 'package:weather_news_app/view/screens/splash_screen.dart';
import 'package:weather_news_app/view/utils/user_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.loadPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
