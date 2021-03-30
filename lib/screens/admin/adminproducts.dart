import 'package:flutter/material.dart';
import '../../screens/admin/addproduct.dart';
import '../../screens/products/myTab.dart';
import '../../widgets/subcategorytab.dart';
import '../../widgets/tabbody.dart';

import '../splash_screen.dart';

class AdminProducts extends StatefulWidget {
  final String locationId;
  final int index;
  final void Function(int, int, String) onButtonTapped;
  AdminProducts({this.locationId, this.index, this.onButtonTapped});
  @override
  _AdminProductsState createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts>
    with SingleTickerProviderStateMixin {
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
      print(widget.index);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          onTap: (index) {},
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
          MyTab(
            locationId: widget.locationId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab("././assets/images/subcategory/tv.png", "TVs"),
              SubCategoryTab(
                  "././assets/images/subcategory/washing-machine.png",
                  "Washing\nMachine"),
              SubCategoryTab(
                  "././assets/images/subcategory/fridge.png", "Refrigerators"),
              SubCategoryTab("././assets/images/subcategory/ac.png", "ACs"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc513ba5cf916fc193c7a"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc56aba5cf916fc193c7c"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc5b7ba5cf916fc193c7d"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab(
                  "././assets/images/subcategory/gamepad.png", "Consoles"),
              SubCategoryTab(
                  "././assets/images/subcategory/printer.png", "Printers"),
              SubCategoryTab(
                  "././assets/images/subcategory/camera.png", "Cameras"),
              SubCategoryTab(
                  "././assets/images/subcategory/monitor.png", "Monitors"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc66274b118cbd7c8c4e7"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc69a74b118cbd7c8c4e8"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc6ad74b118cbd7c8c4e9"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc6ba74b118cbd7c8c4ea"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 7,
            tabs: [
              SubCategoryTab("./assets/images/subcategory/bed.png", "Beds"),
              SubCategoryTab("./assets/images/subcategory/sofa.png", "Sofas"),
              SubCategoryTab(
                  "././assets/images/subcategory/mattress.png", "Mattresses"),
              SubCategoryTab(
                  "././assets/images/subcategory/wardrobe.png", "Wardrobes"),
              SubCategoryTab("././assets/images/subcategory/dressing-table.png",
                  "Dressing\nTable"),
              SubCategoryTab(
                  "././assets/images/subcategory/chair.png", "Chairs"),
              SubCategoryTab(
                  "././assets/images/subcategory/table.png", "Tables"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc69395ca98caec8d12bb"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc6f8d525bf1c04b4b470"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc86bd525bf1c04b4b474"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc896d525bf1c04b4b475"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc964d525bf1c04b4b476"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc76ad525bf1c04b4b471"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc7f7d525bf1c04b4b472"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab("././assets/images/subcategory/dumble.png",
                  "Gym\nEssentials"),
              SubCategoryTab(
                  "././assets/images/subcategory/treadmill.png", "Treadmills"),
              SubCategoryTab(
                  "././assets/images/subcategory/stationary-bike.png",
                  "Exercise Bikes"),
              SubCategoryTab("././assets/images/subcategory/bench-press.png",
                  "Fitness Bench"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc812bafedb7aabe4c787"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc7c9bafedb7aabe4c785"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc77dbafedb7aabe4c784"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc7f2bafedb7aabe4c786"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab(
                  "././assets/images/subcategory/bean-bag.png", "Bean Bags"),
              SubCategoryTab("././assets/images/subcategory/wardrobe.png",
                  "Collapsible\nWardrobes"),
              SubCategoryTab(
                  "././assets/images/subcategory/cabinet.png", "Cabinets"),
              SubCategoryTab(
                  "././assets/images/subcategory/bookshelf.png", "Bookshelves"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc73d74b118cbd7c8c4ed"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc71474b118cbd7c8c4ec"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc6f874b118cbd7c8c4eb"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc75374b118cbd7c8c4ee"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 3,
            tabs: [
              SubCategoryTab(
                  "././assets/images/subcategory/stove.png", "Gas Stoves"),
              SubCategoryTab("././assets/images/subcategory/book-rack.png",
                  "Kitchen Racks"),
              SubCategoryTab(
                  "././assets/images/subcategory/microwave.png", "Microwave"),
            ],
            tabBody: [
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc862bafedb7aabe4c78a"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc891bafedb7aabe4c78c"),
              TabBody(widget.locationId, "$serverLink/api/productslist",
                  "603cc87abafedb7aabe4c78b"),
            ],
          ),
        ],
        // controller: widget.tabController,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProduct(widget.onButtonTapped)));
        },
        label: Text(
          "Add Product",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
    // );
  }
}
