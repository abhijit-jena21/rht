import 'package:flutter/material.dart';

class MyProgressIndicator extends StatefulWidget {
  final bool visible;
  MyProgressIndicator({this.visible});
  MyProgressIndicatorWidget createState() => MyProgressIndicatorWidget();
}

class MyProgressIndicatorWidget extends State<MyProgressIndicator> {
  bool visible = false;

  loadProgress() {
    if (visible == true) {
      // setState(() {
      visible = false;
      // });
    } else {
      // setState(() {
      visible = true;
      // });
    }
  }

  void initState() {
    super.initState();
    
    setState(() {
      visible = widget.visible;
      print("prog"+visible.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: visible,
        child: Container(
            margin: EdgeInsets.only(top: 50, bottom: 30),
            child: LinearProgressIndicator(
              // backgroundColor: Theme.of(context).accentColor,
            )));
  }
}
