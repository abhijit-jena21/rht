import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rht/models/product.dart';
import 'package:rht/widgets/admin/editdetailsform.dart';
import 'package:rht/services/productDetailsService.dart';

class EditDetailsBuilder extends StatefulWidget {
  final StreamController streamController;
  final String productId;
  EditDetailsBuilder({this.streamController, this.productId});
  @override
  _EditDetailsBuilderState createState() => _EditDetailsBuilderState();
}

class _EditDetailsBuilderState extends State<EditDetailsBuilder> {
  ProductDetailsService _detailsService = ProductDetailsService();
  Product res = Product();

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
                return EditDetailsForm(
                  streamController: widget.streamController,
                  snapshot: snapshot.data);
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
                    height: MediaQuery.of(context).size.height,
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
