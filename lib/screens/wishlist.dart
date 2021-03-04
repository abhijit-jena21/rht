import 'package:flutter/material.dart';
import '../screens/wishlistbuilder.dart';
import '../models/product.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Wishlist extends StatefulWidget {
  final String pathUrl;
  final String userId;
  Wishlist({this.pathUrl, this.userId});
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  Dio dio = new Dio();

  userIdentity(userid) async {
    // print(locationid);
    final String pathUrl = widget.pathUrl;
    try {
      print('here22');
      return await dio.post(pathUrl,
          data: {
            "id": userid,
            // "sub": subcategoryid,
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
    print("here");
  }

  Future<List<Product>> _getWishlistedProducts() async {
    Response response =
        await userIdentity(widget.userId);
    print(response.data);
    var responseData = response.data;
    // print(data);
    print('some');

    return (responseData as List).map((x) => Product.fromJson(x)).toList();
  }

  var futureProducts;
  void initState() {
    super.initState();
    setState(() {
      futureProducts = _getWishlistedProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<Product>>(
            future: futureProducts,
            // ignore: missing_return
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "././assets/images/stock.png",
                          height: 200,
                          // scale: 0.5,
                        ),
                        Text(
                          "Your wishlist is empty",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    )),
                  );
                } else {
                  print(snapshot.data);
                  return Container(child: WishlistBuilder(snapshot.data));
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text(
                  'error',
                  style: Theme.of(context).textTheme.headline3,
                );
              } else {
                return Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              
            }));
  }
}
