import 'package:flutter/material.dart';
import 'package:rht/screens/cart.dart';
import './screens/location.dart';
import './screens/starter.dart';
import './utils/theme.dart';

import './screens/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/profile": (BuildContext context) => Starter(location: finalLocation, locationId: finalLocationId, userId: finalId, ),
  "/home": (BuildContext context) => Starter(),
  "/cart":(BuildContext context) => Cart(userId: finalId,),
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
