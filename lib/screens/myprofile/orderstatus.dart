import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rht/models/currentorders.dart';
import 'package:rht/models/userproduct.dart';
import 'package:rht/screens/starter.dart';
import 'package:rht/services/orderservice.dart';

import '../splash_screen.dart';
import '../../utils/orderstatusbuilder.dart';

class OrderStatus extends StatefulWidget {
  // void Function(int) onButtonTapped;
  final String from;
  OrderStatus({this.from});
  // OrderStatus(this.onButtonTapped);
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  Dio dio = new Dio();
  OrderService orderService = new OrderService();
  // ignore: unused_field
  Starter _starter;
  //  GlobalKey<StarterState> _starterKey;

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
      futureProducts = orderService.getTransitOrders(finalId);
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
                // Starter.starterKey.currentState.onButtonTapped2(3);
                if (widget.from == "success")
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Starter(
                                location: finalLocation,
                                locationId: finalLocationId,
                                index: 3,
                                userId: finalId,
                              )),
                      (_) => false
                      // Navigator.pop(context);
                      // widget.onButtonTapped(3);
                      );
                else if (widget.from == "profile") Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Order Status",
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
                              "No orders currently in transit",
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
                          child: OrderStatusBuilder(snapshot.data));
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
        // bottomSheet: Container(
        //   color: Color(0Xfff2f2f2),
        //   width: double.infinity,
        //   height: 50,
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       Column(
        //         children: [
        //           Container(
        //             height: 20,
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: StreamBuilder<Object>(
        //                 stream: streamController.stream,
        //                 builder: (context, snapshot) {
        //                   return Text(
        //                     snapshot.data != null
        //                         ? 'Rent: ₹${snapshot.data}/month'
        //                         : "",
        //                     style: TextStyle(
        //                         fontSize: 15,
        //                         color: Colors.black,
        //                         fontFamily: "Montserrat"),
        //                   );
        //                 }),
        //           ),
        //           Container(
        //             height: 20,
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: StreamBuilder<Object>(
        //                 stream: streamController2.stream,
        //                 builder: (context, snapshot) {
        //                   return Text(
        //                     snapshot.data != null
        //                         ? 'Deposit: ₹${snapshot.data}'
        //                         : '',
        //                     style: TextStyle(
        //                         fontSize: 10,
        //                         color: Colors.black,
        //                         fontFamily: "Montserrat"),
        //                   );
        //                 }),
        //           ),
        //         ],
        //       ),
        //       proceedButton(context)
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
