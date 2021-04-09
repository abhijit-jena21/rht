import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rht/screens/myprofile/orderstatus.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => {
        Navigator.pushAndRemoveUntil(
          context,
            MaterialPageRoute(
              builder: (context) => OrderStatus(from: "success")), (_) => false)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Thanks for renting with RHT",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black87)),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Icon(
              Icons.check_circle,
              color: Theme.of(context).accentColor,
              size: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // RaisedButton(
          //   color: Theme.of(context).buttonColor,
          //   onPressed: () {},
          //   child: Text(
          //     "View Order",
          //     style: Theme.of(context)
          //         .textTheme
          //         .button
          //         .copyWith(fontWeight: FontWeight.bold),
          //   ),
          // )
        ],
      ),
    ));
  }
}
