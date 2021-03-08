import 'package:flutter/material.dart';
import 'package:rht/widgets/tabbody.dart';
import '../../widgets/subcategorytab.dart';

class FurnitureTab extends StatefulWidget {
  final String locationId;
  final String userId;
  FurnitureTab({this.locationId, this.userId});
  @override
  _FurnitureTabState createState() => _FurnitureTabState();
}

class _FurnitureTabState extends State<FurnitureTab>
    with TickerProviderStateMixin
    // , AutomaticKeepAliveClientMixin
    {
  // @override
  // bool get wantKeepAlive => true;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 7);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection(){
    setState(() {
          
        });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(appBar: 
      AppBar(
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
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/bed.png?raw=true", "Beds"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/sofa.png?raw=true", "Sofas"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/mattress.png?raw=true", "Mattresses"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/wardrobe.png?raw=true", "Wardrobes"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/dressing%20table.png?raw=true", "Dressing\nTable"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/office%20chair.png?raw=true", "Chairs"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/office%20table.png?raw=true", "Tables"),
            // SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/dining%20table.png?raw=true", "Dining Tables"),
        ],),),
        body: TabBarView(
            controller: _tabController,
            children: [
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc69395ca98caec8d12bb"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc6f8d525bf1c04b4b470"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc86bd525bf1c04b4b474"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc896d525bf1c04b4b475"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc964d525bf1c04b4b476"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc76ad525bf1c04b4b471"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc7f7d525bf1c04b4b472"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
            ],
          )
        
        ),
    );
}
    }
