import "package:flutter/material.dart";
import 'package:dio/dio.dart';

import '../models/product.dart';
import '../screens/splash_screen.dart';
import '../screens/productdetail.dart';
import "../my_navigator.dart";
import '../services/wishlistservice.dart';

MyNavigator myNavigator;

class ProductCard extends StatefulWidget {
  final String userId;
  final String productId;
  final String name;
  final List<String> img;
  final String details;
  final int price;
  final int rent;
  final int duration;
  final String locationId;
  final List<String> items;
  ProductCard(this.userId, this.productId, this.name, this.img, this.details,
      this.price, this.rent, this.duration, this.items, this.locationId);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavourite;
  bool isFav = false;
  String response;
  Dio dio = new Dio();
  WishlistService wishlistService = new WishlistService();

  List<Product> wishlistedProducts;
  void initState() {
    print("gggg");
    super.initState();

    wishlistService.getWishlistedProducts(widget.userId).then((result) {
      if (this.mounted) {
        setState(() {
          wishlistedProducts = result;
        });
      }
    });
  }

  // foobar() async {
  //   await _getWishlistedProducts();
  // }

  @override
  Widget build(BuildContext context) {
    // print("hereiam" + wishlistedProducts[0].sId);
    if (wishlistedProducts != null) {
      for (var index = 0; index < wishlistedProducts.length; index++) {
        if (widget.productId == wishlistedProducts[index].sId) {
          isFav = true;
          break;
        } else
          isFav = false;
      }
    }
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        widget.userId,
                        widget.productId,
                        widget.name,
                        widget.img,
                        widget.details,
                        widget.price,
                        widget.rent,
                        widget.duration,
                        widget.locationId,
                        widget.items
                        )));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    shape: BoxShape.rectangle,
                    // border: Border.all(color: Colors.black26, width: 0.5),
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
                            width: 25,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: Colors.white,
                              onPressed: () async {
                                isFavourite =
                                    await wishlistService.responseFromWishlist(
                                        finalId, widget.productId, isFav);
                                wishlistedProducts = await wishlistService
                                    .getWishlistedProducts(widget.userId);
                                print("2");

                                print("sss" + isFavourite.toString());
                                setState(() {
                                  isFav = isFavourite;
                                });
                              },
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red.shade400,
                                size: 18,
                              ),
                            ),
                          ),
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
                    height: 20,
                    child: Text(widget.name,
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
                    child: Text("₹ " + widget.rent.toString() + '/month',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            // fontFamily: 'Varela',
                            fontSize: 12.0)),
                  ),
                ]))));
  }
}
