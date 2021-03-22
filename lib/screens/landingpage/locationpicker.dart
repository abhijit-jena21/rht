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
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: FlatButton.icon(
        padding: EdgeInsets.zero,
        height: 25,
        icon: Icon(
          Icons.location_on,
          color: Colors.yellow,
          size: 20,
        ),
        // minWidth: double.infinity,
        label: Text('$_location',
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
