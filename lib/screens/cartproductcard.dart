import "package:flutter/material.dart";
import "package:dio/dio.dart";
import '../screens/splash_screen.dart';
import '../services/cartservice.dart';
import "../my_navigator.dart";

MyNavigator myNavigator;

class CartProductCard extends StatefulWidget {
  final String userId;
  final int index;
  final Function(int) notifyParent;
  final int count;
  final int duration;
  final int rent;
  final String img;
  final String locationId;
  final String name;
  final String productId;

  // final String locationId;
  // String imgPath,
  // final List<String> items;
  CartProductCard(
    this.userId,
    this.index,
    this.notifyParent,
    this.count,
    this.duration,
    this.rent,
    this.img,
    this.locationId,
    this.name,
    this.productId,
  );
  @override
  _CartProductCardState createState() => _CartProductCardState(count);
}

class _CartProductCardState extends State<CartProductCard> {
  bool isFavourite = false;
  bool isFav = false;
  String response;
  int stock;
  int _btn1SelectedVal;
  _CartProductCardState(this._btn1SelectedVal);
  Dio dio = new Dio();
  CartService cartService = new CartService();

  static const menuItems = <int>[
    1,
    2,
  ];
  final List<DropdownMenuItem<int>> _dropDownMenuItems = menuItems
      .map(
        (int value) => DropdownMenuItem<int>(
          value: value,
          child: Text(
            value.toString(),
            style: TextStyle(
                color: Colors.black87, fontFamily: "Montserrat", fontSize: 15),
          ),
        ),
      )
      .toList();

  // void initState() {
  //   super.initState();
  //   cartService.getStock(widget.productId).then((result) {
  //     setState(() {
  //       stock = result;
  //     });
  //   });
  // }

  // Widget stockWidget() {
  //   if (stock > widget.count)
  //     return Container(
  //       child: Text("In stock",
  //           style: Theme.of(context)
  //               .textTheme
  //               .bodyText1
  //               .copyWith(fontWeight: FontWeight.normal, color: Colors.green)),
  //     );
  //   else if (stock < widget.count)
  //   return Container(
  //       child: Text("Only $stock left",
  //           style: Theme.of(context)
  //               .textTheme
  //               .bodyText1
  //               .copyWith(fontWeight: FontWeight.normal, color: Colors.red)),
  //     );
  //   else if (stock == 0)
  //   return Container(
  //       child: Text("Out of stock",
  //           style: Theme.of(context)
  //               .textTheme
  //               .bodyText1
  //               .copyWith(fontWeight: FontWeight.normal, color: Colors.red)),
  //     );


  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {},
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
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      constraints: BoxConstraints.loose(Size.fromHeight(100)),
                      height: 110,
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.img ??
                                  "https://4.bp.blogspot.com/-1f1SDFIx3dY/Uh92eZAQ90I/AAAAAAAAHM4/5oiB4zC_tQ4/s1600/Photo-Background-White4.jpg"),
                              fit: BoxFit.contain))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text(
                          "${widget.name}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: Color(0xFFFFA751),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text("₹${widget.rent}/month",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text("${widget.duration} months",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.normal)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // stockWidget()
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "   Qty:   ",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Container(
                              child: DropdownButton<int>(
                                // Must be one of items.value.
                                value: _btn1SelectedVal,
                                iconSize: 20,

                                onChanged: (int newValue) {
                                  setState(() {
                                    _btn1SelectedVal = newValue;
                                  });
                                },
                                items: this._dropDownMenuItems,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          "Remove",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {
                          await cartService
                              .deleteFromCart(finalId, widget.productId,
                                  widget.count, widget.duration)
                              .whenComplete(() {
                            widget.notifyParent(widget.index);
                          });
                        },
                      )
                    ],
                  )
                ]))));
  }
}
