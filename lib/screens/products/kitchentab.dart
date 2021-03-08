import 'package:flutter/material.dart';
import 'package:rht/widgets/tabbody.dart';
import '../../widgets/subcategorytab.dart';

class KitchenTab extends StatefulWidget {
  final String locationId;
  final String userId;
  KitchenTab({this.locationId, this.userId});
  @override
  _KitchenTabState createState() => _KitchenTabState();
}

class _KitchenTabState extends State<KitchenTab>
    with TickerProviderStateMixin
    // ,AutomaticKeepAliveClientMixin
    {
  // @override
  // bool get wantKeepAlive => true;
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

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            toolbarHeight: 100,
            title: TabBar(
              // indicator: Decoration.,
              indicatorPadding: EdgeInsets.zero,
              controller: _tabController,
              isScrollable: true,
              indicatorWeight: 2.0,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color(0xffffffff),
              unselectedLabelColor: Colors.grey[700],
              labelColor: Theme.of(context).accentColor,
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
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TabBody(
                  widget.locationId,widget.userId, "http://10.0.3.2:8080/api/productslist","603cc862bafedb7aabe4c78a"),
              TabBody(
                  widget.locationId, widget.userId,"http://10.0.3.2:8080/api/productslist","603cc891bafedb7aabe4c78c"),
              TabBody(
                  widget.locationId,widget.userId, "http://10.0.3.2:8080/api/productslist","603cc87abafedb7aabe4c78b"),
              // TabBody(
              //     widget.locationId, "http://10.0.3.2:8080/api/productslist"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
            ],
          )),
    );
  }
}
