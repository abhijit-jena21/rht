import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rht/models/categorylist.dart';
import '../../screens/products/myTab.dart';
import '../../widgets/subcategorytab.dart';
import '../../widgets/tabbody.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../splash_screen.dart';

// ignore: must_be_immutable
class Products extends StatefulWidget {
  final int index;
  final String locationId;
  final String userId;
  Products({Key key, this.index, this.locationId, this.userId})
      : super(key: key);
  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var futureCategory;
  List<CategoryList> result;
  Dio dio = new Dio();
  category() async {
    var endpointUrl = '$serverLink/api/categorylist';
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

  Future<List<CategoryList>> _getCategory() async {
    Response response = await category();
    print(response.data);
    print(response.data.runtimeType);
    var str = response.data.toString();
    print(str);
    var parsed = json.decode(str);
    print(parsed.runtimeType);

    if (parsed != null)
      result = List<CategoryList>.from(parsed.map((x) => CategoryList.fromJson(x)));
    print(result);
    print(result.length);
    for (var i = 0; i < result.length; i++) {
      print(result[i].category);
      print(result[i].subcategory);
    }

    return result;
  }

  Tab categoryTabs(String category) {
    return Tab(
      child: Container(
        child: Text(
          category,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 6, initialIndex: 0);
    setState(() {
      futureCategory = _getCategory();
      tabController.animateTo(widget.index);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("products" + widget.userId);
    print("receiving" + widget.index.toString());
    return FutureBuilder<List<CategoryList>>(
        future: futureCategory,
        // ignore: missing_return
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Container(
                  height: MediaQuery.of(context).size.height,
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
                        "nothing...",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.black87),
                      ),
                    ],
                  )),
                ),
              );
            } else {
              print("snapshot" + snapshot.data.toString());
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 48,
                  elevation: 0,
                  backgroundColor: Colors.grey.shade200,
                  title: TabBar(
                    controller: tabController,
                    indicatorPadding: EdgeInsets.zero,
                    isScrollable: true,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black87,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    onTap: (index) {},
                    tabs: [
                      for (var i = 0; i < snapshot.data.length; i++)
                        categoryTabs(snapshot.data[i].category),
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: tabController,
                  children: [
                    for (var i = 0; i < snapshot.data.length; i++)
                      MyTab(
                        locationId: widget.locationId,
                        userId: widget.userId,
                        tabNumber: snapshot.data[i].subcategory.length,
                        tabs: [
                          for (var j = 0;
                              j < snapshot.data[i].subcategory.length;
                              j++)
                            SubCategoryTab(snapshot.data[i].subcategory[j].img,
                                snapshot.data[i].subcategory[j].name),
                        ],
                        tabBody: [
                          for (var j = 0;
                              j < snapshot.data[i].subcategory.length;
                              j++)
                            TabBody(
                                widget.locationId,
                                "$serverLink/api/productslist",
                                snapshot.data[i].subcategory[j].subid,
                                widget.userId),
                        ],
                      ),
                  ],
                  // controller: widget.tabController,
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text(
              'error',
              style: Theme.of(context).textTheme.headline3,
            );
          } else {
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          }
        });
    // );
  }
}
