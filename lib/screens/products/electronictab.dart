import 'package:flutter/material.dart';
import '../../widgets/tabbody.dart';
import '../../widgets/subcategorytab.dart';

class ElectronicTab extends StatefulWidget {
  final String locationId;
  ElectronicTab({this.locationId});
  @override
  _ElectronicTabState createState() => _ElectronicTabState();
}

class _ElectronicTabState extends State<ElectronicTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection(){
    setState(() {
          
        });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/console.jpg?raw=true", "Consoles"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/printer.png?raw=true", "Printers"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/camera.png?raw=true", "Cameras"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/monitor.png?raw=true", "Monitors"),
        ],),),
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
          )
        
        ),
    );
}
    }
