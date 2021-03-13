import "package:flutter/material.dart";
import 'package:dio/dio.dart';

import "../../my_navigator.dart";

MyNavigator myNavigator;

class AdminProductCard extends StatefulWidget {
  final String productId;
  final String name;
  final List<String> img;
  final String details;
  final int price;
  final int rent;
  final int duration;
  final String locationId;
  final List<String> items;
  AdminProductCard(this.productId, this.name, this.img, this.details,
      this.price, this.rent, this.duration, this.items, this.locationId);
  @override
  _AdminProductCardState createState() => _AdminProductCardState();
}

class _AdminProductCardState extends State<AdminProductCard> {
  bool isFavourite;
  bool isFav = false;
  String response;
  Dio dio = new Dio();

  void initState() {
    print("gggg");
    super.initState();
  }

  // foobar() async {
  //   await _getWishlistedProducts();
  // }
  static const menuItems = <String>[
    'Edit',
    'Delete'
  ];
  String _selectedVal;

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> _popUpMenuItems = menuItems.map(
    (String value) => PopupMenuItem<String>(
      value: value,
      child: Text(value,
      style: Theme.of(context).textTheme.headline3,),
    ),
  ).toList();
    // print("hereiam" + wishlistedProducts[0].sId);
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 110,
                    // width: 110,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      // overflow: Overflow.clip,
                      fit: StackFit.loose,
                      children: [
                        // Hero(
                        //     tag: imgPath,
                        Container(
                            // alignment: Alignment.center,
                            constraints:
                                BoxConstraints.loose(Size.fromHeight(100)),
                            height: 110,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.img[0]),
                                    fit: BoxFit.contain))),
                        Positioned(
                          top: 5,
                          right: 10,
                          child: SizedBox(
                              height: 25,
                              width: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                                // color: Colors.white,
                                alignment: Alignment.center,
                                child: PopupMenuButton<String>(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                                  onSelected: (String newValue){
                                    _selectedVal = newValue;
                                  },
                                  itemBuilder: (BuildContext context) => _popUpMenuItems,
                                ),
                              )),
                        ),
                        if (widget.items.length == 0)
                          Positioned(
                            bottom: 5,
                            // right: 10,
                            child: SizedBox(
                                height: 25,
                                width: 75,
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.redAccent,
                                  child: Text(
                                    "Out of stock",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                )),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    child: Text(widget.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            // fontFamily: 'Varela',
                            fontSize: 12.0)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    height: 20,
                    child: Text("₹ " + widget.rent.toString() + '/month',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFFCC8053),
                            // fontFamily: 'Varela',
                            fontSize: 12.0)),
                  ),
                ]))));
  }
}
