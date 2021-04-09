import 'package:flutter/material.dart';
import '../services/wishlistservice.dart';
import '../utils/wishlistbuilder.dart';
import '../models/product.dart';
import 'package:dio/dio.dart';

class Wishlist extends StatefulWidget {
  final String pathUrl;
  final String userId;
  final void Function(int) onButtonTapped;
  Wishlist({this.pathUrl, this.userId, this.onButtonTapped});
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  Dio dio = new Dio();
  WishlistService wishlistService = new WishlistService();
  var futureProducts;
  void initState() {
    super.initState();
    setState(() {
      futureProducts = wishlistService.getWishlistedProducts(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // height: MediaQuery.of(context).size.h,
            child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                "My Wishlist",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Product>>(
                future: futureProducts,
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(futureProducts.toString());
                    print(snapshot.data.toString());
                    if (snapshot.data == null) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "././assets/images/empty.png",
                            height: 200,
                            // scale: 0.5,
                          ),
                          Text(
                            "Your wishlist is empty",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black87),
                          ),
                        ],
                      ));
                    } else {
                      print(snapshot.data);
                      return Container(
                          child: WishlistBuilder(snapshot.data, widget.userId,
                              widget.onButtonTapped));
                    }
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text(
                      'error',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height *0.9,
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                }),
          ],
        )),
      ),
    );
  }
}
