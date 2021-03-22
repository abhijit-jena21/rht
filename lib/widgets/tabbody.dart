import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../widgets/productlist.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import '../widgets/productcard.dart';

import '../models/product.dart';

class TabBody extends StatefulWidget {
  final String locationId;
  final String userId;
  final String pathUrl;
  final String subcategoryId;
  TabBody(this.locationId,  this.pathUrl, this.subcategoryId, [this.userId,]);
  @override
  _TabBodyState createState() => _TabBodyState();
}

class _TabBodyState extends State<TabBody> {
  Dio dio = new Dio();
  productlocation(locationid, subcategoryid) async {
    print(locationid);
    final String pathUrl = widget.pathUrl;
    try {
      // print('here22');
      return await dio.post(pathUrl,
          data: {
            "id": locationid,
            "sub": subcategoryid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      // print('here33');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
    // print("here");
  }

  Future<List<Product>> _getProducts() async {
    // List<Product> products = [];
    // var products;
    Response response =
        await productlocation(widget.locationId, widget.subcategoryId);
    // print(response.data);
    var responseData = response.data;
    // print(data);
    // print('some');

    return (responseData as List).map((x) => Product.fromJson(x)).toList();
  }

  var futureProducts;
  void initState() {
    super.initState();
    setState(() {
      futureProducts = _getProducts();
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
                          "Restocking soon...",
                          style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black87),
                        ),
                      ],
                    )),
                  );
                } else {
                  print(snapshot.data);
                  return Container(
                      child: ProductList(snapshot.data, widget.userId));
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
