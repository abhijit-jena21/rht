import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_navigator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xFFDEB788),
                child: Text(
                  'HOME SCREEN ',
                  style: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  child: Text('Logout'),
                  onPressed: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove('phone');
                    MyNavigator.goToLogin(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
