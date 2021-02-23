import 'package:flutter/material.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String _location = "Select Location";
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                createItem('Bangalore'),
                createItem('Chennai'),
                createItem('Hyderabad'),
                createItem('Mumbai'),
                createItem('Ahmedabad'),
                createItem('New Delhi'),
                createItem('Kolkata'),
                createItem('Bhubaneswar'),
                createItem('Lucknow'),
              ],
            ),
          );
        });
  }

  ListTile createItem(String name) {
    return ListTile(
      title: Center(
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      onTap: () => _selectItem(name),
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _location = name;
    });
  }
}
