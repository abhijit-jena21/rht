import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import "../models/subcategory_repo.dart";

class SubCategories extends StatefulWidget {
  final String id;
  SubCategories(this.id);

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  // final CategoriesScroller categoriesScroller = CategoriesScroller();
  
  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = SubCategory;
    List<Map<String, String>> filteredResponseList =
        responseList.where((category) => category['id'] == widget.id).toList();
    List<Widget> listItems = [];
    filteredResponseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      post["sub_id"],
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                        fontSize: 15,

                      )
                    ),
                  ],
                ),
                Image.network(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/${post["image"]}?raw=true",
                  // height: double.infinity,
                  width: 100,
                )
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  void initState() {
    super.initState();
    getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(widget.id, style: Theme.of(context).textTheme.headline2),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: itemsData.length,
                      itemBuilder: (context, index) {
                        return Align(
                            heightFactor: 0.7,
                            alignment: Alignment.topCenter,
                            child: itemsData[index]);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
