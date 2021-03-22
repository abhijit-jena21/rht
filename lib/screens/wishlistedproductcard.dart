import "package:flutter/material.dart";
import "package:dio/dio.dart";
import 'package:rht/models/product.dart';
import '../services/wishlistservice.dart';
import '../screens/productdetail.dart';
import "../my_navigator.dart";

MyNavigator myNavigator;

class WishlistedProductCard extends StatefulWidget {
  final String userId;
  final void Function(int) onButtonTapped;
  final int index;
  final Function(int) notifyParent;
  final Product snapshot;

  WishlistedProductCard(
    this.userId,
    this.onButtonTapped,
    this.index,
    this.notifyParent,
    this.snapshot
  );
  @override
  _WishlistedProductCardState createState() => _WishlistedProductCardState();
}

class _WishlistedProductCardState extends State<WishlistedProductCard> {
  bool isFavourite = false;

  bool isFav = true;
  String response;
  Dio dio = new Dio();
  WishlistService wishlistService = new WishlistService();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                          widget.snapshot)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    shape: BoxShape.rectangle,
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.grey.withOpacity(0.2),
                    //       spreadRadius: 3.0,
                    //       blurRadius: 5.0)
                    // ],
                    color: Colors.white),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 110,
                    // width: 110,
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.loose,
                      children: [
                        // Hero(
                        //     tag: imgPath,
                        Container(
                            constraints:
                                BoxConstraints.loose(Size.fromHeight(100)),
                            height: 110,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.snapshot.img[0]),
                                    fit: BoxFit.contain))),
                        if (widget.snapshot.itemsid.length == 0)
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            height: 20,
                            child: Text(widget.snapshot.name,
                                overflow: TextOverflow.ellipsis,
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
                            child:
                                Text("₹ " + widget.snapshot.rent.toString() + '/month',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        // fontFamily: 'Varela',
                                        fontSize: 12.0)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.grey[200],
                          onPressed: () async {
                            isFavourite = await wishlistService
                                .responseFromWishlist(
                                    widget.userId, widget.snapshot.sId, isFav)
                                .whenComplete(() {
                              widget.notifyParent(widget.index);
                            });
                            print("isFavourite:$isFavourite");
                          },
                          child: Icon(
                            Icons.delete,
                            color: Color(0xFF999999),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]))));
  }
}
