import 'package:flutter/material.dart';
import 'package:rht/screens/starter.dart';

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
    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return Container(
    //         height: 200,
    //         child: ListView(
    //           scrollDirection: Axis.vertical,
    //           children: [
    //             createItem('Bangalore', '6035f6e437bb23b5e8310b41'),
    //             createItem('Chennai', '6035f85e87e39d26742469fl'),
    //             createItem('Hyderabad', '6035f85e87e39d26742469fa'),
    //             createItem('Mumbai', '6035f85e87e39d26742469ff'),
    //             createItem('Ahmedabad', '6035f85e87e39d26742469fc'),
    //             createItem('New Delhi', '6035f85e87e39d26742469fz'),
    //             createItem('Kolkata', '6035f85e87e39d26742469fd'),
    //             createItem('Bhubaneswar', '6035f85e87e39d26742469ff'),
    //             createItem('Lucknow', '6035f85e87e39d26742469fe'),
    //           ],
    //         ),
    //       );
    //     });
  }

//   ListTile createItem(String name, String locationId) {
//     return ListTile(
//       title: Center(
//         child: Text(
//           name,
//           style: Theme.of(context).textTheme.bodyText1,
//         ),
//       ),
//       onTap: () => _selectItem(name, locationId),
//     );
//   }

//   void _selectItem(String name, String locationId) {
//     Navigator.pop(context);
//     setState(() {
//       _location = name;
//       Starter(
//         title: name,
//         locationId: locationId,
//       );
//     });
//   }
}
