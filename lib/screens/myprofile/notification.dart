/*import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

  class _NotificationScreenState extends State<NotificationScreen>{

  
   bool _switch = false;
   bool _swtch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title:Text("My Notifications")
      , 
        leading:IconButton(icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {Navigator.of(context).pop();
                        },),
      
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height:18,),
            Row(
              children:<Widget>[
                Icon(
                  Icons.volume_up,
                  color: Color(0xFFFFA751),
                  size: 24.0,
                ),
                SizedBox(width: 8,),

             Text(
          "PUSH NOTIFICATION-",
          
          style: TextStyle(color:Color(0xFFFFA751),
          fontWeight: FontWeight.w800,
          fontSize: 18.0
          ),
          
        ),
              ],
            ),
            Divider(height:15, thickness:1 ,),
            SizedBox(height:25 ,),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal :0,),
          child: Column(
            children: <Widget>[
              SwitchListTile(
                
                activeColor: Color(0xFFFFA751),
              
              title: Text("Receive Notifications"),
                onChanged: (bool value) {
                  setState(() => this._swtch = value);
                }, 
                value: this._swtch,
                ),
                _buildDivider(),
              SwitchListTile(
                
                 activeColor: Color(0xFFFFA751),
              value: _switch,
              title: Text("Receive newsletter"),
                onChanged: (bool value){},),
                _buildDivider(),
                SwitchListTile( 
                  
                  activeColor: Color(0xFFFFA751),
              value: _swtch,
              title: Text("Receive Offer Notifications"),
                onChanged: (bool value) {},),
                _buildDivider(),
                SwitchListTile(
                  
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
}*/