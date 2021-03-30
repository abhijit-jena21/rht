import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rht/models/userproduct..dart';
import 'package:rht/screens/myprofile/pastordersbuilder.dart';
import 'package:rht/services/orderservice.dart';

import '../splash_screen.dart';
import '../starter.dart';
import 'currentordersbuilder.dart';

class PastOrders extends StatefulWidget {
  @override
  _PastOrdersState createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  Dio dio = new Dio();
  OrderService orderService = new OrderService();
  Starter _starter;

  var futureProducts;
  void initState() {
    super.initState();
    _starter = new Starter(
      location: finalLocation,
      locationId: finalLocationId,
      index: 3,
      userId: finalId,
    );

    setState(() {
      futureProducts = orderService.getPastOrders(finalId);
      // test();
    });
  }

  void test() async {
    var testVar = await orderService.getTransitOrders(finalId);
    print(testVar.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              onPressed: () {
                // Navigator.pop(context);
                Starter.starterKey.currentState.onButtonTapped2(3);
                // Navigator.pop(context);
                // widget.onButtonTapped(3);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Past Orders",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder<List<UserProduct>>(
                future: futureProducts,
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(futureProducts.toString());
                    print(snapshot.data.toString());
                    if (snapshot.data == null) {
                      return Container(
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
                              "You haven't ordered anything",
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
                          child: PastOrdersBuilder(snapshot.data));
                    }
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text(
                      'error',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 30),
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

