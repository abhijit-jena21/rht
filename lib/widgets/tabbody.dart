import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../screens/splash_screen.dart';
import '../widgets/productlist.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import '../widgets/productcard.dart';

import '../models/product.dart';

class TabBody extends StatefulWidget {
  final String locationId;
  final String userId;
  final String pathUrl;
  final String subcategoryId;
  TabBody(
    this.locationId,
    this.pathUrl,
    this.subcategoryId, [
    this.userId,
  ]);
  @override
  _TabBodyState createState() => _TabBodyState();
}

class _TabBodyState extends State<TabBody> {
  Dio dio = new Dio();
  productlocation(locationid, subcategoryid, pageNumber) async {
    var endpointUrl =
        '$serverLink/api/productslist/$locationid/$subcategoryid/$pageNumber';

    print(locationid);
    print(endpointUrl);
    try {
      return await dio.get(
        endpointUrl,
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<ProductPage> _getProducts(String pageNumber) async {
    Response response = await productlocation(
        widget.locationId, widget.subcategoryId, pageNumber);
    print(response.data);
    print(response.data.runtimeType);
    Map<String, dynamic> map = json.decode(response.toString());
    var result = ProductPage.fromJson(map);
    return result;
  }

  var futureProducts;
  void initState() {
    super.initState();
    setState(() {
      futureProducts = _getProducts(0.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<ProductPage>(
            future: futureProducts,
            // ignore: missing_return
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.products == null) {
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
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.black87),
                        ),
                      ],
                    )),
                  );
                } else {
                  print(snapshot.data);
                  return Container(
                      child: ProductList(
                          snapshot.data, widget.userId, _getProducts));
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text(
                  'error',
                  style: Theme.of(context).textTheme.headline3,
                );
              } else {
                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }));
  }
}
