import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../screens/splash_screen.dart';
import '../services/cartservice.dart';

import '../models/product.dart';
import '../services/wishlistservice.dart';
import '../utils/sliderutil.dart';
import 'cart.dart';

class ProductDetail extends StatefulWidget {
  final Product snapshot;
  ProductDetail(this.snapshot);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int calculatedRent;
  // _ProductDetailState(this.calculatedRent);

  Product product = new Product();
  // MySlider mySlider;
  var indexTop = 3;
  int duration = 24;
  bool isFavourite;
  bool isFav = false;
  String response;
  Dio dio = new Dio();
  List items = [];
  WishlistService wishlistService = new WishlistService();
  CartService cartService = new CartService();

  List<Product> wishlistedProducts;
  // Product productDetails;

  Widget buildLabel({String label}) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        // width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.black87),
        ),
      );

  Widget buildSliderTopLabel() {
    final labels = ['3+', '    6+', '      12+', '24+'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: SliderUtil.modelBuilder(
                // ignore: missing_return
                labels, (index, label) {
              // final isSelected = index <= indexTop;
              return buildLabel(label: label);
            }),
          ),
        ),
        Slider(
            value: indexTop.toDouble(),
            min: min,
            max: max,
            divisions: divisions,
            activeColor: Theme.of(context).accentColor,
            inactiveColor: Colors.blue[700],
            onChanged: (newRent) {
              print(newRent);
              setState(
                () {
                  this.indexTop = newRent.toInt();

                  if (indexTop == 0) {
                    calculatedRent = (widget.snapshot.rent * 1.15).toInt();
                    duration = 3;
                  } else if (indexTop == 1) {
                    calculatedRent = (widget.snapshot.rent * 1.1).toInt();
                    duration = 6;
                  } else if (indexTop == 2) {
                    calculatedRent = (widget.snapshot.rent * 1.05).toInt();
                    duration = 12;
                  } else if (indexTop == 3) {
                    calculatedRent = widget.snapshot.rent;
                    duration = 24;
                  }
                },
              );
            } // label: labels[indexTop],
            ),
      ],
    );
  }

  Widget imageCarousel(items) => Container(
        height: 50.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          images: items,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          showIndicator: false,
          autoplay: false,
        ),
      );

  void initState() {
    super.initState();
    calculatedRent = widget.snapshot.rent;
    wishlistService.getWishlistedProducts(finalId).then((result) {
      if (this.mounted) {
        setState(() {
          wishlistedProducts = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var images = [];

    if (wishlistedProducts != null) {
      for (var index = 0; index < wishlistedProducts.length; index++) {
        if (widget.snapshot.sId == wishlistedProducts[index].sId) {
          isFav = true;
          break;
        } else
          isFav = false;
      }
    }
    // calculatedRent = widget.rent;
    widget.snapshot.img.forEach((data) {
      images.add(NetworkImage(data));
    });

    void showActionSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 70),
        // padding: EdgeInsets.symmetric(horizontal: 20),
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Added to Cart",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "View Cart",
          textColor: Color(0xFFFFA751),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(
                          userId: finalId,
                        )));
          },
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    Widget addToCart(BuildContext context) {
      Color conditionalColor;
      void Function() _onPressed;
      print("locationid" + widget.snapshot.locationid);
      // print("shared" + finalLocationId);
      if (widget.snapshot.stock <= 0 ||
          (widget.snapshot.locationid != finalLocationId)) {
        setState(() {
          conditionalColor = Colors.grey;
          print("i");
          _onPressed = null;
        });
      } else if (widget.snapshot.itemsid.length > 0) {
        setState(() {
          print("am");
          conditionalColor = Theme.of(context).accentColor;
          var now = DateTime.now();
          var formatter = DateFormat('yyyy-MM-dd');
          String formattedDate = formatter.format(now);
          String finalDate = '${formattedDate}T00:00:00.000+00:00';
          _onPressed = () async {
            var response = await cartService.addToCart(
                finalId,
                widget.snapshot.sId,
                finalLocationId,
                widget.snapshot.name,
                1,
                duration,
                calculatedRent,
                widget.snapshot.img[0],
                finalDate,
                widget.snapshot.deposit);
            print(response.toString());
            if (response.toString() == "New product added" ||
                response.toString() == "Count of product increased")
              showActionSnackBar(context);
          };
        });
      }
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4,
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: Theme.of(context).buttonColor,
          onPressed: _onPressed,
          child: Text('ADD TO CART', style: Theme.of(context).textTheme.bodyText2),
        ),
      );
    }

    buildImage(int index){
      return Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 5, 10),
                    padding: EdgeInsets.all(20),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                        // border: Border(),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: images.elementAt(index) != null
                                ? images.elementAt(index)
                                : NetworkImage(
                                    "https://oconnorpg.com/wp-content/uploads/2019/05/White-Square.jpg"))),
                    // child: NetworkImage(url: widget.img[0]),
                  );
    }

    List<Widget> buildImageRow(){
      List<Widget> imageBox = List<Widget>();
      for(var i=0; i<widget.snapshot.img.length;i++)
      {
        imageBox.add(buildImage(i));
      }
      return imageBox;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.red.shade400,
              // size: 18,
            ),
            onPressed: () async {
              isFavourite = await wishlistService.responseFromWishlist(
                  finalId, widget.snapshot.sId, isFav);
              wishlistedProducts =
                  await wishlistService.getWishlistedProducts(finalId);
              print("2");
              print("sss" + isFavourite.toString());
              setState(() {
                isFav = isFavourite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              child: imageCarousel(images),
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text('${widget.snapshot.name}',
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold))),
            if (widget.snapshot.stock <= 0)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                color: Colors.redAccent,
                child: Text(
                  "Out of stock",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            if (widget.snapshot.locationid != finalLocationId)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                color: Colors.blue[100],
                child: Text(
                  "This product isn't available in this city",
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 12),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 50,
                  // width: double.infinity/2,
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text('₹ $calculatedRent',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold)),
                      ),
                      Column(
                        children: [
                          Text('/month',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.black54)),
                          SizedBox(
                            height: 3,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: Text('Deposit Amount:\n ₹ ${widget.snapshot.deposit}',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.black87)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 40),
              height: 30,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.local_shipping),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Free delivery in 72 hours",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.black87),
                ),
              ]),
              // color: Colors.blue[100],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // ],
            // ),m
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 30,
              color: Colors.grey.shade200,
              child: Text(
                "How many months do you want to rent this for?",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: buildSliderTopLabel()),
            SizedBox(height: 10),
            Container(
              // height: 100,
              color: Colors.blue.shade50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
              child: Text('Safety precautions during Covid-19',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.black87,
                      height: 1,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              // height: 100,
              color: Colors.blue.shade50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                  'We\'re taking additional steps and measures to protect you from COVID-19',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.black87, height: 1.2)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: buildImageRow(),
            ),
            Container(
              // height: 100,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Product Details',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Theme.of(context).primaryColor,
                      height: 1.5,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              // height: 100,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('${widget.snapshot.details}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black87, height: 1.5)),
            ),
            Container(
              // height: 100,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Terms and Conditions',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Theme.of(context).primaryColor,
                      height: 1.5,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_balance_wallet_rounded, color: Theme.of(context).accentColor,size: 30,),
                        SizedBox(width: 10,),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Refundable Deposit",
                              style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric( vertical: 10),
                                child: Text("You will need to pay deposit amount upfront. Monthly rent will be collected each month from your delivery date.",
                                style: Theme.of(context).textTheme.caption.copyWith(color: Colors.black87),
                                maxLines: 4,),
                              )
                            ],
                          ),
                        )
                      ],),
                  )
                ],),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, color: Theme.of(context).accentColor,size: 30,),
                        SizedBox(width: 10,),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Renting Tenure",
                              style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric( vertical: 10),
                                child: Text("Rent agreement will remain valid for the tenure you\'ve selected. In order to continue using the product, you will need to rent the item again.",
                                style: Theme.of(context).textTheme.caption.copyWith(color: Colors.black87),
                                maxLines: 4,),
                              )
                            ],
                          ),
                        )
                      ],),
                  )
                ],),
            ),

            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: Color(0Xfff2f2f2),
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    '₹$calculatedRent/month',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                ),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    'Deposit: ₹${widget.snapshot.deposit}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                ),
              ],
            ),
            addToCart(context)
          ],
        ),
      ),
    );
  }
}
