import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rht/screens/checkout.dart';
import 'package:rht/screens/splash_screen.dart';
import '../services/usercheckservice.dart';
import '../models/cartproduct.dart';
import '../services/cartservice.dart';
import 'package:dio/dio.dart';
import './cartbuilder.dart';

import 'cartbuilder.dart';
import 'login.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class Cart extends StatefulWidget {
  final String pathUrl;
  final String userId;
  // final void Function(int) onButtonTapped;
  Cart({this.pathUrl, this.userId});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();
  // final GlobalKey<CartBuilderState> _cartKey = GlobalKey();
  final StreamController streamController = StreamController.broadcast();
  final StreamController streamController2 = StreamController.broadcast();

  Dio dio = new Dio();
  bool exist;
  int cartSum = 0;
  CartService cartService = new CartService();
  var response = false;
  Usercheck usercheck = Usercheck();
  var futureProducts;
  var res = Res();
  void initState() {
    super.initState();
    if (finalPhone == null) {
      exist = false;
      {
        print("User doesn\'t exist");
      }
    } else {
      exist = true;
    }
    setState(() {
      futureProducts = cartService.getCartProducts(widget.userId);

      // cartSum = sumOfRent();
    });
  }

  void dispose() {
    super.dispose();
    streamController.close();
    streamController2.close();
  }

  void updateCartSum(int receivedSum) {
    setState(() {
      cartSum = receivedSum;
    });
  }

  void showActionSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 70),
      // padding: EdgeInsets.symmetric(horizontal: 20),
      behavior: SnackBarBehavior.floating,
      content: Text(
        "Some Products in cart are unavailable",
        style:
            Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
      ),
      // action: SnackBarAction(
      //   label: "View Cart",
      //   textColor: Color(0xFFFFA751),
      //   onPressed: () {},
      // ),
    );
    _scaffoldKey2.currentState.showSnackBar(snackBar);
  }

  // ignore: missing_return
  Widget proceedButton(BuildContext context) {
    // Color conditionalColor = Theme.of(context).accentColor;
    void Function() _onPressed;
    // print("here" + res.result);
    _onPressed = () async {
      var response = await cartService.respondStock(widget.userId);
      // bool stock = response;
      print(response);
      print(response.runtimeType);
      // var text1 = utf8.encode("success").toString();
      // print(text1);
      // var text2 = utf8.encode(response).toString();
      // print(text2);
      // bool stock = false;
      // print("stcok response" + response.toString());
      if (response.compareTo("fail") == 0) {
        print("iamhere");
        showActionSnackBar(context);
      } else if (response.compareTo("success") == 0) {
        print("mehere");
        // usercheck.account(finalId, exist).then((result) {
        //   print(result);
        //   final Map parsed = json.decode(result.toString());
        //   res = Res.fromJson(parsed);
        //   print(res.result);
        if (finalPhone == null) {
          print(finalPhone.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen("/checkout")));
        } else
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CheckOut()));
        // });
      }
    };
    // if () {
    //   setState(() {
    //     conditionalColor = Colors.grey;
    //     print("i");
    //     _onPressed = null;
    //   });
    // } else if (widget.items.length > 0) {
    //   setState(() {
    //     print("am");
    //     conditionalColor = Theme.of(context).accentColor;
    //     var now = DateTime.now();
    //     var formatter = DateFormat('yyyy-MM-dd');
    //     String formattedDate = formatter.format(now);
    //     String finalDate = '${formattedDate}T00:00:00.000Z';
    //     _onPressed = () async {
    //       var response = await cartService.addToCart(
    //           finalId,
    //           widget.productId,
    //           finalLocationId,
    //           widget.name,
    //           1,
    //           duration,
    //           calculatedRent,
    //           widget.img[0],
    //           finalDate);
    //       print(response.toString());
    //       if (response.toString() == "New product added" ||
    //           response.toString() == "Count of product increased")
    //         showActionSnackBar(context);
    //     };
    //   });
    // }
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).buttonColor,
        onPressed: _onPressed,
        child: Text(
          'PROCEED',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey2,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // height: MediaQuery.of(context).size.h,
            child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              color: Theme.of(context).primaryColor,
              child: Text(
                "My Cart",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<CartProduct>>(
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
                              "././assets/images/empty.png",
                              height: 200,
                              // scale: 0.5,
                            ),
                            Text(
                              "Your cart is empty",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        )),
                      );
                    } else {
                      print(snapshot.data);
                      return Container(
                          child: CartBuilder(
                              snapshot.data, widget.userId, streamController, streamController2));
                    }
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text(
                      'error',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else {
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
        bottomSheet: Container(
          color: Color(0Xfff2f2f2),
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: StreamBuilder<Object>(
                        stream: streamController.stream,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data != null
                                ? 'Rent: ₹${snapshot.data}/month'
                                : "",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Montserrat"),
                          );
                        }),
                  ),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: StreamBuilder<Object>(
                      stream: streamController2.stream,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data!=null
                          ? 'Deposit: ₹${snapshot.data}'
                          :'',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontFamily: "Montserrat"),
                        );
                      }
                    ),
                  ),
                ],
              ),
              proceedButton(context)
            ],
          ),
        ),
      ),
    );
  }
}
