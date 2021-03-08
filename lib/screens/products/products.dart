import 'package:flutter/material.dart';

import './appliancetab.dart';
import './electronictab.dart';
import './furnituretab.dart';
import './fitnesstab.dart';
import './spacesavertab.dart';
import './kitchentab.dart';

// ignore: must_be_immutable
class Products extends StatefulWidget {
  TabController tabController;
  final int index;
  final String locationId;
  final String userId;
  Products(
      {Key key, this.tabController, this.index, this.locationId, this.userId})
      : super(key: key);
  // Products.getC({Key key, @required this.tabController, @required this.index})
  //     : super(key: key);
  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products>
    with SingleTickerProviderStateMixin
    // , AutomaticKeepAliveClientMixin 
    {
  //   @override
  // bool get wantKeepAlive => true;  
  TabController tabController;
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
      // _tabController.animateTo(widget.index);
    });
  }

  // void _setActiveTabIndex() {
  //   var _activeTabIndex = _tabController.index;
  // }

  @override
  void dispose() {
    tabController.dispose();
    // nextPage(0);
    super.dispose();
  }

  // void nextPage(int tab) {
  //   final int newTab = _tabController.index + tab;
  //   print("newtab" + newTab.toString());
  //   if (newTab < 0 || newTab >= _tabController.length)
  //     _tabController.animateTo(newTab);
  // }

  // print(widget.index)

  @override
  Widget build(BuildContext context) {
    print("products" + widget.userId);
    print("receiving" + widget.index.toString());
    return
        // DefaultTabController(
        //   initialIndex: widget.index == null ? 0 : widget.index,
        //   // initialIndex: 0,
        //   length: 6,
        //   child:
        Scaffold(
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
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          onTap: (index) {
            // // print(widget.tabController);
            // print("index" + index.toString());
            // print(widget.index);
            // setState(() {
            //   widget.index = index;
            // });
            // _tabController.animateTo(index);
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
        controller: tabController,
        children: [
          ApplianceTab(locationId: widget.locationId, userId: widget.userId),
          ElectronicTab(locationId: widget.locationId, userId: widget.userId),
          FurnitureTab(locationId: widget.locationId, userId: widget.userId),
          FitnessTab(locationId: widget.locationId, userId: widget.userId),
          SpacesaverTab(locationId: widget.locationId, userId: widget.userId),
          KitchenTab(locationId: widget.locationId, userId: widget.userId),
        ],
        // controller: widget.tabController,
      ),
    );
    // );
  }
}
