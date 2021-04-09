import 'package:flutter/material.dart';
import 'package:rht/screens/splash_screen.dart';

import 'currentordertab.dart';

class AdminOrders extends StatefulWidget {
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders>
    with TickerProviderStateMixin {
    Tab ordersTabs(String category) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
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

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            toolbarHeight: 70,
            title: TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 5),
              indicatorPadding: EdgeInsets.zero,
              controller: _tabController,
              isScrollable: true,
              indicatorWeight: 2.0,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Theme.of(context).accentColor,
              unselectedLabelColor: Colors.grey[700],
              labelColor: Theme.of(context).primaryColor,
              tabs: [
                ordersTabs("Current Orders"),
                ordersTabs("Past Orders"),
                ordersTabs("In Transit"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              CurrentOrderTab(pathUrl:"$serverLink/api/userlist/currentorder",from: "currentorder",),
              CurrentOrderTab(pathUrl:"$serverLink/api/userlist/pastorder",from: "pastorder",),
              CurrentOrderTab(pathUrl:"$serverLink/api/userlist/intransit", from: "intransit",)
            ],
          )),
    );
  }
}
