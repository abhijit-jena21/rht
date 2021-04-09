import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rht/models/currentorders.dart';
import 'package:rht/services/orderservice.dart';

import '../splash_screen.dart';
import '../starter.dart';
import '../../utils/currentordersbuilder.dart';

class CurrentOrders extends StatefulWidget {
  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  Dio dio = new Dio();
  OrderService orderService = new OrderService();
  // ignore: unused_field
  Starter _starter  = new Starter(
      location: finalLocation,
      locationId: finalLocationId,
      index: 3,
      userId: finalId,
    );
  //  GlobalKey<StarterState> _starterKey;

  var futureProducts;
  var intransit;
  void initState() {
    super.initState();
    // _starter

    setState(() {
      intransit = orderService.getTransitOrders(finalId);
      futureProducts = orderService.getCurrentOrders(finalId);
      });
      print("whencomplete");
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
            "Current Orders",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder<List<Currentorder>>(
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
                          child: CurrentOrdersBuilder(snapshot.data));
                    }
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text(
                      'error',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
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
                    );
                  }
                }),
          ],
        )),
      ),
    );
  }
}
