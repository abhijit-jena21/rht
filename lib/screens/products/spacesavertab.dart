import 'package:flutter/material.dart';
import 'package:rht/widgets/tabbody.dart';
import '../../widgets/subcategorytab.dart';

class SpacesaverTab extends StatefulWidget {
  final String locationId;
  final String userId;
  SpacesaverTab({this.locationId, this.userId});
  @override
  _SpacesaverTabState createState() => _SpacesaverTabState();
}

class _SpacesaverTabState extends State<SpacesaverTab>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
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
                // SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/hammock.png?raw=true", "Hammock\nSwings"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TabBody(
                  widget.locationId,widget.userId, "http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(
                  widget.locationId,widget.userId, "http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(
                  widget.locationId,widget.userId, "http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(
                  widget.locationId,widget.userId, "http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
            ],
          )),
    );
  }
}
