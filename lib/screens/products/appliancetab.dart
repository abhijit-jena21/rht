import 'package:flutter/material.dart';
import '../../widgets/subcategorytab.dart';
import '../../widgets/tabbody.dart';

class ApplianceTab extends StatefulWidget {
  final String locationId;
  ApplianceTab({this.locationId});
  @override
  _ApplianceTabState createState() => _ApplianceTabState();
}

class _ApplianceTabState extends State<ApplianceTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                // SubCategoryTab(
                //     "https://www.github.com/abhijit-jena21/image-repo/blob/main/toaster.png?raw=true",
                //     "Toasters"),
                // SubCategoryTab(
                //     "https://www.github.com/abhijit-jena21/image-repo/blob/main/fan.png?raw=true",
                //     "Fans"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
            ],
          )),
    );
  }
}
