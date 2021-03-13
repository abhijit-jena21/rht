import 'package:flutter/material.dart';

import '../location.dart';

class LocationPicker extends StatefulWidget {
  final String locationId;
  final String location;
  final String userId;
  LocationPicker({this.location, this.locationId, this.userId});
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String _location;
  @override
  void initState() {
    // setState(() {
    _location = widget.location;
    // });

    super.initState();
  }

  // _location=widget.location;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      height: 20,
      child: FlatButton(
        height: 20,
        minWidth: double.infinity,
        child: Text('$_location', style: Theme.of(context).textTheme.bodyText2),
        onPressed: () => _onButtonPressed(),
      ),
    );
  }

  void _onButtonPressed() {
    // Navigator.pushNamed(context, "/location");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Location(userId: widget.userId)),
        (_) => false);
  }

}
