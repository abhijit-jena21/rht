import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_navigator.dart';
import './admin/adminstarter.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                // backgroundColor: Colors.black,
                backgroundImage: AssetImage("assets/images/img.png"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.grey[200],
                    onPressed: () {},
                    child: Icon(Icons.photo),
                  ),
                ),
              ),
            ],
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
        ),
        Container(
          alignment: Alignment.center,
          child: FlatButton(
            child: Text('Go To Admin'),
            onPressed: () {
              print("adminlocation" + finalAdminLocation.toString());
              print("adminlocationid" + finalAdminLocationId.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminStarter(
                            adminLocation: finalAdminLocation,
                            adminLocationId: finalAdminLocationId,
                          )));
            },
          ),
        )
      ],
    );
  }
}
