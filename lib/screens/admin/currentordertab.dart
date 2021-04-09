
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rht/models/currentorders.dart';
import 'package:rht/utils/admin/currentorderbuilder.dart';
import 'package:rht/screens/splash_screen.dart';

class CurrentOrderTab extends StatefulWidget {
  final String pathUrl;
  final String from;
  CurrentOrderTab({this.pathUrl, this.from});
  @override
  _CurrentOrderTabState createState() => _CurrentOrderTabState();
}

class _CurrentOrderTabState extends State<CurrentOrderTab> {
  Dio dio = new Dio();
  fetchlist() async {
    print(widget.pathUrl);
    try {
      print("here22");
      return await dio.get(widget.pathUrl,
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Token': '$finalToken',
            'Admin': '$finalAdmin'
          }));
    } catch (e) {
      // print('here33');
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
    // print("here");
  }

  Future<List<CurrentOrders>> _getUsers() async {
    // List<Product> products = [];
    // var products; 
    var response = await fetchlist();
    print("response:" + response.data.toString());
    var responseData = response.data;
    print(responseData);
    print(responseData.runtimeType);
    if(responseData=="Token is expired" || responseData=="Not Authorized")
    {
      Fluttertoast.showToast(
          msg: 'PLease login again',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
    return (responseData as List)
        .map((x) => CurrentOrders.fromJson(x))
        .toList();
  }

  var futureProducts;
  void initState() {
    super.initState();
    setState(() {
      futureProducts = _getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<CurrentOrders>>(
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
                          "No orders here...",
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
                      child: CurrentOrderBuilder(
                          snapshot: snapshot.data, from: widget.from));
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
