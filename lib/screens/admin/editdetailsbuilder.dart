import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rht/models/product.dart';
import 'package:rht/screens/admin/editdetailsform.dart';
import 'package:rht/services/productDetailsService.dart';

class EditDetailsBuilder extends StatefulWidget {
  final String productId;
  EditDetailsBuilder({this.productId});
  @override
  _EditDetailsBuilderState createState() => _EditDetailsBuilderState();
}

class _EditDetailsBuilderState extends State<EditDetailsBuilder> {
  ProductDetailsService _detailsService = ProductDetailsService();
  Product res = Product();
  // ignore: missing_return
  // _getProduct() async {
  //   // List<Product> products = [];
  //   // var products;
  //   print("entered here");
  //   await _detailsService.post(widget.productId).then((val) {
  //     print("here" + val.toString());
  //     final Map parsed = json.decode(val.toString());
  //     print("entered here too");
  //     res = Product.fromJson(parsed);
  //   });

  //   // print(response.data);
  //   // print(data);
  //   // print('some');
  // }

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
                      child: Center(
                          child: Column(
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
                      )),
                    )));
              } else {
                print(snapshot.data);
                return EditDetailsForm(snapshot:snapshot.data);
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
                  body: SingleChildScrollView(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )));
            }
          }),
    );
  }
}
