import 'package:flutter/material.dart';

import './appliancetab.dart';
import './electronictab.dart';
import './furnituretab.dart';
import './fitnesstab.dart';
import './spacesavertab.dart';
import './kitchentab.dart';

// ignore: must_be_immutable
class Products extends StatefulWidget {
  final TabController tabController;
  int index = 0;
  String locationId;
  Products({Key key, this.tabController, this.index, this.locationId}) : super(key: key);
  Products.getC({Key key, @required this.tabController, @required this.index})
      : super(key: key);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products>
    with SingleTickerProviderStateMixin {
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

  // print(widget.index)

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.index == null ? 0 : widget.index,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 48,
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
          title: TabBar(
            // controller: widget.tabController,

            indicatorPadding: EdgeInsets.zero,
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black87,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            onTap: (index) {
              // print(widget.tabController);
              print("index" + index.toString());
              print(widget.index);
              setState(() {
                widget.index = index;
              });
            },
            tabs: [
              categoryTabs("Appliances"),
              categoryTabs("Electronics"),
              categoryTabs("Furniture"),
              categoryTabs("Fitness"),
              categoryTabs("Space Saver"),
              categoryTabs("Kitchen")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ApplianceTab(locationId: widget.locationId,),
            ElectronicTab(locationId: widget.locationId,),
            FurnitureTab(locationId: widget.locationId,),
            FitnessTab(locationId: widget.locationId,),
            SpacesaverTab(locationId: widget.locationId,),
            KitchenTab(locationId: widget.locationId,),
          ],
          // controller: widget.tabController,
        ),
      ),
    );
  }
}
