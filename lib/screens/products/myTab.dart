import 'package:flutter/material.dart';

class MyTab extends StatefulWidget {
  final String locationId;
  final String userId;
  final int tabNumber;
  final List<Widget> tabBody;
  final List<Widget> tabs;
  MyTab({this.locationId, this.userId, this.tabNumber, this.tabBody, this.tabs});
  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab>
    with TickerProviderStateMixin
    // , AutomaticKeepAliveClientMixin
    {
  // @override
  // bool get wantKeepAlive => true;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: widget.tabNumber);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    // print("appliance" + widget.userId);
    return DefaultTabController(
      length: widget.tabNumber,
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
              tabs: widget.tabs,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: widget.tabBody,
          )),
    );
  }
}
