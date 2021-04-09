import 'package:flutter/material.dart';

import '../screens/location.dart';
import '../screens/splash_screen.dart';

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
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      // ignore: deprecated_member_use
      child: FlatButton.icon(
        padding: EdgeInsets.zero,
        height: 25,
        icon: Icon(
          Icons.location_on,
          color: Colors.white,
          size: 20,
        ),
        // minWidth: double.infinity,
        label: Text('$finalAdminLocation',
            style: Theme.of(context).textTheme.bodyText2 ,
            overflow: TextOverflow.ellipsis),
        onPressed: () => _onButtonPressed(),
      ),
    );
  }

  void _onButtonPressed() {
    // Navigator.pushNamed(context, "/location");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Location(userId: widget.userId)));
  }
}
