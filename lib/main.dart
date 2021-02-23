import 'package:flutter/material.dart';
import 'package:rht/screens/starter.dart';
import './utils/theme.dart';

// import './screens/starter.dart';
import './screens/splash_screen.dart';
import './screens/signup.dart';
import './screens/login.dart';
// import './screens/home.dart';

var routes =< String, WidgetBuilder>{
  "/signup": (BuildContext context) => SignupScreen(),
  // "/otp": (BuildContext context) => OtpScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/home": (BuildContext context) => Starter(),
};

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home: SplashScreen(),
      routes: routes,
    );
  }
}

