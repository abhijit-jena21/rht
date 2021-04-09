import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rht/models/product.dart';
import 'package:rht/screens/productdetail.dart';
import 'package:rht/services/productDetailsService.dart';

class ProductDetailBuilder extends StatefulWidget {
  final String productId;
  final void Function(int) callback;
  ProductDetailBuilder({this.productId, this.callback});
  @override
  _ProductDetailBuilderState createState() => _ProductDetailBuilderState();
}

class _ProductDetailBuilderState extends State<ProductDetailBuilder> {
  ProductDetailsService _detailsService = ProductDetailsService();
  Product res = Product();
  // ignore: missing_return
  // ignore: unused_element
  _getProduct() async {
    // List<Product> products = [];
    // var products;
    print("entered here");
    await _detailsService.post(widget.productId).then((val) {
      print("here" + val.toString());
      final Map parsed = json.decode(val.toString());
      print("entered here too");
      res = Product.fromJson(parsed);
    });

    // print(response.data);
    // print(data);
    // print('some');
  }

  var futureProduct;
  void initState() {
    super.initState();
    setState(() {
      futureProduct = _detailsService.response(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // height: MediaQuery.of(context).size.h,
      child: FutureBuilder<Product>(
          future: futureProduct,
          // ignore: missing_return
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Image.asset(
                            "././assets/images/empty.png",
                            height: 200,
                            // scale: 0.5,
                          ),
                          Text(
                            "Couldn't load details",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black87),
                          ),
                      ],
                    ),
                        )));
              } else {
                print(snapshot.data);
                return ProductDetail(snapshot:snapshot.data, callback: widget.callback);
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                      child: Text(
                    'error',
                    style: Theme.of(context).textTheme.headline3,
                  )));
            } else {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          // padding: EdgeInsets.symmetric(vertical: 30),
                          children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ])));
            }
          }),
    );
  }
}
