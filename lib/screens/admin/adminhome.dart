import 'package:flutter/material.dart';
import '../../screens/landingpage/locationpicker.dart';

class AdminHome extends StatefulWidget {
  final String location;
  final String locationId;
  AdminHome({this.location, this.locationId});
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    print("admin" + widget.location);
    print("admin" + widget.locationId);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'RHT Admin',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        // bottomNavigationBar: MyBottomNavigationBar(),
        body: Container(
            child: ListView(shrinkWrap: true, children: [
          LocationPicker(
            location: widget.location,
            locationId: widget.locationId,
          ),
        ])));
  }
}
