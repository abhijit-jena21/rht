import 'package:flutter/material.dart';
import '../../screens/admin/addproduct.dart';
import '../../screens/products/myTab.dart';
import '../../widgets/subcategorytab.dart';
import '../../widgets/tabbody.dart';

import '../splash_screen.dart';

class AdminProducts extends StatefulWidget {
  final String locationId;
  AdminProducts({this.locationId});
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
    setState(() {});
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
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/tv.png?raw=true",
                  "TVs"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/washing.png?raw=true",
                  "Washing\nMachine"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/refrigerator.png?raw=true",
                  "Refrigerators"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/ac.png?raw=true",
                  "ACs"),
            ],
            tabBody: [
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc4bfba5cf916fc193c79"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc513ba5cf916fc193c7a"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc56aba5cf916fc193c7c"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc5b7ba5cf916fc193c7d"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/console.jpg?raw=true",
                  "Consoles"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/printer.png?raw=true",
                  "Printers"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/camera.png?raw=true",
                  "Cameras"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/monitor.png?raw=true",
                  "Monitors"),
            ],
            tabBody: [
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc66274b118cbd7c8c4e7"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc69a74b118cbd7c8c4e8"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc6ad74b118cbd7c8c4e9"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc6ba74b118cbd7c8c4ea"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 7,
            tabs: [
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/bed.png?raw=true",
                  "Beds"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/sofa.png?raw=true",
                  "Sofas"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/mattress.png?raw=true",
                  "Mattresses"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/wardrobe.png?raw=true",
                  "Wardrobes"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/dressing%20table.png?raw=true",
                  "Dressing\nTable"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/office%20chair.png?raw=true",
                  "Chairs"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/office%20table.png?raw=true",
                  "Tables"),
            ],
            tabBody: [
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc69395ca98caec8d12bb"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc6f8d525bf1c04b4b470"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc86bd525bf1c04b4b474"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc896d525bf1c04b4b475"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc964d525bf1c04b4b476"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc76ad525bf1c04b4b471"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc7f7d525bf1c04b4b472"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/dumb%20bell.png?raw=true",
                  "Gym\nEssentials"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/treadmill.png?raw=true",
                  "Treadmills"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/exercise%20bike.png?raw=true",
                  "Exercise Bikes"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/fitness%20bench.png?raw=true",
                  "Fitness Bench"),
            ],
            tabBody: [
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc812bafedb7aabe4c787"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc7c9bafedb7aabe4c785"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc77dbafedb7aabe4c784"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc7f2bafedb7aabe4c786"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 4,
            tabs: [
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/bean%20bag.png?raw=true",
                  "Bean Bags"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/collapsible%20wardrobe.png?raw=true",
                  "Collapsible\nWardrobes"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/cabinet.png?raw=true",
                  "Cabinets"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/bookshelf.png?raw=true",
                  "Bookshelves"),
            ],
            tabBody: [
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc73d74b118cbd7c8c4ed"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc71474b118cbd7c8c4ec"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc6f874b118cbd7c8c4eb"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc75374b118cbd7c8c4ee"),
            ],
          ),
          MyTab(
            locationId: widget.locationId,
            tabNumber: 3,
            tabs: [
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/gas%20stove.png?raw=true",
                  "Gas Stoves"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/kitchen%20rack.png?raw=true",
                  "Kitchen Racks"),
              SubCategoryTab(
                  "https://www.github.com/abhijit-jena21/image-repo/blob/main/micro%20wave.png?raw=true",
                  "Microwave"),
            ],
            tabBody: [
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc862bafedb7aabe4c78a"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc891bafedb7aabe4c78c"),
              TabBody(
                  widget.locationId,
                  "$serverLink/api/productslist",
                  "603cc87abafedb7aabe4c78b"),
            ],
          ),
        ],
        // controller: widget.tabController,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        label: Text("Add Product",
        style: Theme.of(context).textTheme.headline3.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    // );
  }
}
