import "package:flutter/material.dart";
import 'package:dio/dio.dart';
import 'package:rht/utils/productdetailbuilder.dart';

import '../models/product.dart';
import '../screens/splash_screen.dart';
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
  final int deposit;
  final int duration;
  final String locationId;
  final List<String> items;
  final int stock;
  ProductCard(
      this.userId,
      this.productId,
      this.name,
      this.img,
      this.details,
      this.price,
      this.rent,
      this.deposit,
      this.duration,
      this.items,
      this.stock,
      this.locationId);
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

  void changeLikedVal(int val) {
    setState(() {
      isFav = !isFav;
      print("done" + isFav.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print("stock:" + widget.stock.toString());
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
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailBuilder(
                          productId: widget.productId,
                          callback: changeLikedVal))).then((value) async => {
                    print("setstate"),
                    await wishlistService
                        .getWishlistedProducts(widget.userId)
                        .then((result) {
                      if (this.mounted) {
                      print("here");
                      setState(() {
                        wishlistedProducts = result;
                        if (wishlistedProducts != null) {
                          for (var index = 0;
                              index < wishlistedProducts.length;
                              index++) {
                            if (widget.productId ==
                                wishlistedProducts[index].sId) {
                              isFav = true;
                              break;
                            } else
                              isFav = false;
                          }
                        } else if (wishlistedProducts == null) isFav = false;
                      });
                      }
                    }),
                    print("set"),
                  });
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    shape: BoxShape.rectangle,
                    color: Colors.white),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 110,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      fit: StackFit.loose,
                      children: [
                        Container(
                            constraints:
                                BoxConstraints.loose(Size.fromHeight(100)),
                            height: 110,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                image: DecorationImage(
                                    image: NetworkImage(widget.img[0]),
                                    colorFilter: (widget.stock <= 0 ||
                                            widget.stock == null)
                                        ? ColorFilter.mode(
                                            Colors.grey, BlendMode.saturation)
                                        : null,
                                    fit: BoxFit.cover))),
                        if (widget.stock <= 0)
                          Positioned(
                            bottom: 15,
                            child: SizedBox(
                                height: 25,
                                width: 100,
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.redAccent,
                                  child: Text(
                                    "Out of stock",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
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
                            child: Text(widget.name,
                                // maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xFF575E67), fontSize: 12.0)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            height: 20,
                            child: Text(
                                "₹ " + widget.rent.toString() + '/month',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 12.0)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          padding: EdgeInsets.only(right: 10),
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
                              print("setstate" + isFav.toString());
                            });
                          },
                          child: Icon(
                            isFav == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red.shade400,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]))));
  }
}
