import 'package:flutter/material.dart';
import 'drawer_bloc.dart';

class NotificationScreen extends StatefulWidget with DrawerStates{
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

  class _NotificationScreenState extends State<NotificationScreen>{

  
   bool _switch = false;
   bool _swtch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        Text(
          "PUSH NOTIFICATION-",
          style: TextStyle(color:Colors.grey.shade800,
          fontWeight: FontWeight.w400,
          fontSize: 18.0
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal :0,),
          child: Column(
            children: <Widget>[
              SwitchListTile(
                secondary:Icon(Icons.swap_vertical_circle),
                activeColor: Color(0xFFFFA751),
              value: _switch,
              title: Text("Receive Notifications"),
                onChanged: (bool value) {},),
                _buildDivider(),
              SwitchListTile(
                secondary:Icon(Icons.swap_vertical_circle),
                 activeColor: Color(0xFFFFA751),
              value: _switch,
              title: Text("Receive newsletter"),
                onChanged: (bool value){},),
                _buildDivider(),
                SwitchListTile( 
                  secondary:Icon(Icons.swap_vertical_circle),
                  activeColor: Color(0xFFFFA751),
              value: _swtch,
              title: Text("Receive Offer Notifications"),
                onChanged: (bool value) {},),
                _buildDivider(),
                SwitchListTile(
                  secondary:Icon(Icons.swap_vertical_circle),
                   activeColor: Color(0xFFFFA751),
              value: _swtch,
              title: Text("Receive App Updates"),
                onChanged: (bool value) {},),
              
             ],
          ),
        ),
          ],
       ),
      ),
      
      );
      }
      Container _buildDivider(){
        return Container (
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          width: double.infinity,
          height: 1.0,
          color: Colors.grey.shade300,
        );
  }
}