import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rht/widgets/productlist.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import '../widgets/productcard.dart';

import '../models/product.dart';

class TabBody extends StatefulWidget {
  final String locationId;
  final String userId;
  final String pathUrl;
  final String subcategoryId;
  TabBody(this.locationId, this.userId, this.pathUrl, this.subcategoryId);
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

    // final res = Product.fromJson(responseData);

    // print(res.runtimeType);

    // for (var u in responseData) {
    //   Product product = Product(
    //       sId: u["_id"],
    //       subcategoryid: u["subcategoryid"],
    //       name: u["name"],
    //       img: u["img"],
    //       details: u["details"],
    //       price: u["price"],
    //       rent: u["rent"],
    //       duration: u["duration"],
    //       itemsid: u["itemsid"],
    //       locationid: u["locationid"]);
    //   products.add(product);
    // }
    // print(products.length);

    // final Map parsed = json.decode(response.toString());
    // final Map parsed = json.decode(response.data);
    // print(parsed);
    // final res = Product.fromJson(my);
    // products.add(res);

    // print(res.arr[0].name);

    // products = res.arr[0];

    // for (var item in res.arr) {
    //   setState(() {
    //     products.add(item);
    //   });
    // }

    // print(res);
    // var result = json.decode(res.body);
    // print(result);
    // result['carousel'].forEach((data)
    // var data = await http.get("http://10.0.3.2:8080/api/productslist");
    // var jsonData = json.decode(data.body);
    // // print(jsonData);

    // for (var u in jsonData) {
    //   Product product = Product(
    //       u["id"], u["name"], u["name"], u["name"], u["name"], u["name"]);
    // return products;
  }

  var futureProducts;
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 3)).then((_) {
    setState(() {
      futureProducts = _getProducts();
    });
    //   return 0;
    // });
    // print("7777"+futureProducts.toString());
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
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    )),
                  );
                } else {
                  print(snapshot.data);
                  return Container(child: ProductList(snapshot.data, widget.userId));
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
              // print(snapshot.data);
              // if (snapshot.hasData) {
              // if (snapshot.data != null) {
              // print(snapshot.data);
              // return Container(child: ProductList(snapshot.data));
              // }
              // } else {
              //   return Container(
              //     child: Center(
              //         child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           "././assets/images/stock.png",
              //           height: 200,
              //           // scale: 0.5,
              //         ),
              //         Text(
              //           "Restocking soon...",
              //           style: Theme.of(context).textTheme.headline3,
              //         ),
              //       ],
              //     )),
              //   );
              // }
            }));
  }
}
