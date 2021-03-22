import 'package:flutter/material.dart';
import '../../screens/products/mytab.dart';
import '../../widgets/subcategorytab.dart';
import '../../widgets/tabbody.dart';

import '../splash_screen.dart';

// ignore: must_be_immutable
class Products extends StatefulWidget {
  final int index;
  final String locationId;
  final String userId;
  Products(
      {Key key, this.index, this.locationId, this.userId})
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
      tabController.animateTo(widget.index);
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

          // ApplianceTab(locationId: widget.locationId, userId: widget.userId),
          MyTab(
            locationId: widget.locationId,
            userId: widget.userId,
            tabNumber: 4,
            tabs: [
                SubCategoryTab(
                    "././assets/images/subcategory/tv.png",
                    "TVs"),
                SubCategoryTab(
                    "././assets/images/subcategory/washing-machine.png",
                    "Washing\nMachine"),
                SubCategoryTab(
                    "././assets/images/subcategory/fridge.png",
                    "Refrigerators"),
                SubCategoryTab(
                    "././assets/images/subcategory/ac.png",
                    "ACs"),
            ],
            tabBody: [
               TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc4bfba5cf916fc193c79",
                  widget.userId),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc513ba5cf916fc193c7a",
                  widget.userId),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc56aba5cf916fc193c7c",
                  widget.userId),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc5b7ba5cf916fc193c7d",
                  widget.userId),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            userId: widget.userId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab(
                    "././assets/images/subcategory/gamepad.png",
                    "Consoles"),
                SubCategoryTab(
                    "././assets/images/subcategory/printer.png",
                    "Printers"),
                SubCategoryTab(
                    "././assets/images/subcategory/camera.png",
                    "Cameras"),
                SubCategoryTab(
                    "././assets/images/subcategory/monitor.png",
                    "Monitors"),
            ],
            tabBody: [
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc66274b118cbd7c8c4e7", widget.userId),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc69a74b118cbd7c8c4e8", widget.userId),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc6ad74b118cbd7c8c4e9", widget.userId),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc6ba74b118cbd7c8c4ea", widget.userId),
            ],
            ),
          MyTab(
            locationId: widget.locationId,
            userId: widget.userId,
            tabNumber: 7,
            tabs: [
              SubCategoryTab("./assets/images/subcategory/bed.png", "Beds"),
              SubCategoryTab("./assets/images/subcategory/sofa.png", "Sofas"),
              SubCategoryTab("./assets/images/subcategory/mattress.png", "Mattresses"),
              SubCategoryTab("./assets/images/subcategory/wardrobe.png", "Wardrobes"),
              SubCategoryTab("./assets/images/subcategory/dressing-table.png", "Dressing\nTable"),
              SubCategoryTab("./assets/images/subcategory/chair.png", "Chairs"),
              SubCategoryTab("./assets/images/subcategory/table.png", "Tables"),
            ],
            tabBody: [
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc69395ca98caec8d12bb",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc6f8d525bf1c04b4b470",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc86bd525bf1c04b4b474",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc896d525bf1c04b4b475",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc964d525bf1c04b4b476",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc76ad525bf1c04b4b471",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc7f7d525bf1c04b4b472",widget.userId),
            ],),
          MyTab(
            locationId: widget.locationId,
            userId: widget.userId,
            tabNumber: 4,
            tabs: [
            SubCategoryTab("././assets/images/subcategory/dumble.png", "Gym\nEssentials"),
            SubCategoryTab("././assets/images/subcategory/treadmill.png", "Treadmills"),
            SubCategoryTab("././assets/images/subcategory/stationary-bike.png", "Exercise Bikes"),
            SubCategoryTab("././assets/images/subcategory/bench-press.png", "Fitness Bench"),
            ],
            tabBody: [
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc7c9bafedb7aabe4c785",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc812bafedb7aabe4c787",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc77dbafedb7aabe4c784",widget.userId),
              TabBody(widget.locationId,"$serverLink/api/productslist","603cc7f2bafedb7aabe4c786",widget.userId),
            ],),
          MyTab(
            locationId: widget.locationId,
            userId: widget.userId,
            tabNumber: 4,
            tabs: [
                SubCategoryTab(
                    "././assets/images/subcategory/bean-bag.png",
                    "Bean Bags"),
                SubCategoryTab(
                    "././assets/images/subcategory/wardrobe.png",
                    "Collapsible\nWardrobes"),
                SubCategoryTab(
                    "././assets/images/subcategory/cabinet.png",
                    "Cabinets"),
                SubCategoryTab(
                    "././assets/images/subcategory/bookshelf.png",
                    "Bookshelves"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist","603cc73d74b118cbd7c8c4ed",widget.userId),
              TabBody(widget.locationId, "$serverLink/api/productslist","603cc71474b118cbd7c8c4ec",widget.userId),
              TabBody(widget.locationId, "$serverLink/api/productslist","603cc6f874b118cbd7c8c4eb",widget.userId),
              TabBody(widget.locationId, "$serverLink/api/productslist","603cc75374b118cbd7c8c4ee",widget.userId),
            ],
            ),
          MyTab(
            locationId: widget.locationId,
            userId: widget.userId,
            tabNumber: 3,
            tabs: [
              SubCategoryTab(
                    "././assets/images/subcategory/stove.png",
                    "Gas Stoves"),
                SubCategoryTab(
                    "././assets/images/subcategory/book-rack.png",
                    "Kitchen Racks"),
                SubCategoryTab(
                    "././assets/images/subcategory/microwave.png",
                    "Microwave"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist","603cc862bafedb7aabe4c78a",widget.userId),
              TabBody(widget.locationId, "$serverLink/api/productslist","603cc891bafedb7aabe4c78c",widget.userId),
              TabBody(widget.locationId, "$serverLink/api/productslist","603cc87abafedb7aabe4c78b",widget.userId),
            ],),
        ],
        // controller: widget.tabController,
      ),
    );
    // );
  }
}
