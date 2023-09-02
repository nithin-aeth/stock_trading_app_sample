import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/screens/login_screen.dart';
import 'package:stock_trading_app/screens/portfolio_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PortfolioProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home:  AnimatedSplashScreen(
        nextScreen: LoginScreen(),
        splash: Image.asset('assets/images/logoo.jpg'),
        duration: 3000,
        backgroundColor: Colors.white,
        splashIconSize: 200,
      ),
    );
  }
}

