import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import '../widgets/productlist.dart';
import '../models/product.dart';

class SearchBody extends StatefulWidget {
  final String pathUrl;
  final String userId;
  final String query;
  final String locationId;
  SearchBody({this.pathUrl, this.userId, this.query, this.locationId});
  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  Dio dio = new Dio();
  productsearch(locationid, query) async {
    print(locationid);
    final String pathUrl = widget.pathUrl;
    try {
      // print('here22');
      return await dio.post(pathUrl,
          data: {
            "search": query,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
    }
  }

  Future<List<Product>> _getProducts() async {
    // List<Product> products = [];
    // var products;
    Response response = await productsearch(widget.locationId, widget.query);
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              // scrollDirection: Axis.vertical,
                // height: MediaQuery.of(context).size.h,
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  "Search results for \'${widget.query}\'",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black87),
                ),
              ),
              FutureBuilder<List<Product>>(
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
                                "Couldn't find anything",
                                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black87),
                              ),
                            ],
                          )),
                        );
                      } else {
                        print(snapshot.data);
                        return ProductList(snapshot.data, widget.userId);
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
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
                  })
            ]))));
  }
}
