import 'package:flutter/material.dart';
import 'package:rht/screens/admin/addproduct.dart';
import 'package:rht/utils/admin/highbuilder.dart';
import 'package:rht/utils/admin/hprofitbuilder.dart';
import 'package:rht/utils/admin/lowbuilder.dart';
import 'package:rht/utils/admin/lowprofitbuilder.dart';
import '../../widgets/locationpicker.dart';

import '../splash_screen.dart';

class AdminHome extends StatefulWidget {
  final String location;
  final String locationId;
  final void Function(int, int, String) onButtonTapped;
  AdminHome({this.location, this.locationId, this.onButtonTapped});
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
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  admin = false;
                });
                Navigator.pop(context);
              }),
          // centerTitle: true,
          title: Text(
            'RHT Admin',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
          actions: [
            LocationPicker(
              locationId: widget.locationId,
              location: widget.location,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Container(
            child: ListView(shrinkWrap: true, children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Products Overview",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black87),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView.count(
              childAspectRatio: 1.5,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                Container(
                  width: 700,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue, width: 1)),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Icon( 
                          Icons.show_chart,
                          color: Colors.green.shade400,
                          size: 50,
                        ),
                        Text(
                          "High\nDemand",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HighBuild()));
                    },
                  ),
                ),
                Container(
                  width: 700,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue, width: 1)),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Icon(
                          Icons.show_chart,
                          color: Colors.red.shade400,
                          size: 50,
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          "Low\nDemand",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LowBuild()));
                    },
                  ),
                ),
                Container(
                  width: 700,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue, width: 1)),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Icon(
                          Icons.stacked_bar_chart,
                          color: Colors.green.shade400,
                          size: 50,
                        ),
                        Text(
                          "High\nProfit",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HighProfitBuild()));
                    },
                  ),
                ),
                Container(
                  width: 700,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue, width: 1)),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Icon(Icons.stacked_bar_chart,
                            color: Colors.red.shade400, size: 50),
                        Text(
                          "Low\nProfit",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LowProfitBuild()));
                    },
                  ),
                ),
              ],
            ),
          )
        ])),
        floatingActionButton: FloatingActionButton.extended(
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddProduct(widget.onButtonTapped)));
                  },
                  label: Text(
                    "Add Product",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
        );
  }
}
