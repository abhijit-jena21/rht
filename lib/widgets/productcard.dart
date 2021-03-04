import "package:flutter/material.dart";
// import 'package:http/http.dart';
import 'dart:async';
import 'package:rht/screens/splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/productdetail.dart';
import 'package:dio/dio.dart';
import "../my_navigator.dart";

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
  // String imgPath,
  final List<String> items;
  ProductCard(this.userId, this.productId, this.name, this.img, this.details,
      this.price, this.rent, this.duration, this.items);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavourite;
  bool isFav = false;
  String response;
  Dio dio = new Dio();

  postToWishlist() async {
    final String pathUrl = "http://10.0.3.2:8080/api/wishlist";
    try {
      print('here22');
      print(widget.userId);
      print(finalId);
      print(widget.productId);
      return await dio.post(pathUrl,
          data: {
            "userid": finalId,
            "productid": widget.productId,
            "status": !isFav,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
    // setState(() {
    //   isFavourite = isFavourite == false ? true : false;
    // });
  }

  // Future<bool>
  Future<bool> responseFromWishlist() async {
    Response response = await postToWishlist();
    print(response.data);
    var responseData = response.data;
    // boolResponse = responseData;
    return responseData;
  }

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
                          widget.name,
                          widget.img,
                          widget.details,
                          widget.price,
                          widget.rent,
                          widget.duration,
                          widget.items)));
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
                      fit: StackFit.expand,
                      children: [
                        // Hero(
                        //     tag: imgPath,
                        Container(
                            height: 110,
                            width: double.infinity,
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
                              color: Colors.grey[200],
                              onPressed: () async {
                                isFavourite = await responseFromWishlist();
                                print("sss" + isFavourite.toString());
                                setState(() {
                                  isFav = isFavourite;
                                });
                              },
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Color(0xFFEF7532),
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