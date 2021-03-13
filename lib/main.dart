import 'package:flutter/material.dart';
import './screens/myprofile/userprofile.dart';
import './screens/checkout.dart';
import './screens/location.dart';
// import 'package:flutter/services.dart';
import './screens/starter.dart';
import './utils/theme.dart';

// import './screens/starter.dart';
import './screens/splash_screen.dart';
import './screens/login.dart';
// import './screens/products.dart';
// import './screens/home.dart';

var routes = <String, WidgetBuilder>{
  // "/signup": (BuildContext context) => SignupScreen(),
  // "/otp": (BuildContext context) => OtpScreen(),
  // "/login": (BuildContext context) => LoginScreen(),
  "/profile": (BuildContext context) => Starter(),
  "/home": (BuildContext context) => Starter(),
  "/checkout":(BuildContext context) => CheckOut(),
  "/location": (BuildContext context) => Location()
};

void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home: SafeArea(child: SplashScreen()),
      routes: routes,
    );
  }
}
