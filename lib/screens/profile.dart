import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_navigator.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
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
    ));
  }
}
