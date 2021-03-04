import 'package:flutter/material.dart';
import 'package:rht/widgets/tabbody.dart';
import '../../widgets/subcategorytab.dart';

class FitnessTab extends StatefulWidget {
  final String locationId;
  final String userId;
  FitnessTab({this.locationId, this.userId});
  @override
  _FitnessTabState createState() => _FitnessTabState();
}

class _FitnessTabState extends State<FitnessTab>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 6);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection(){
    setState(() {
          
        });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
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
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/dumb%20bell.png?raw=true", "Dumbbells"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/treadmill.png?raw=true", "Treadmills"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/bar.png?raw=true", "Bars"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/ab%20exerciser.png?raw=true", "Ab Exerciser"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/exercise%20bike.png?raw=true", "Exercise Bikes"),
            SubCategoryTab("https://www.github.com/abhijit-jena21/image-repo/blob/main/fitness%20bench.png?raw=true", "Fitness Bench"),
        ],),),
        body: TabBarView(
            controller: _tabController,
            children: [
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc77dbafedb7aabe4c784"),
              TabBody(widget.locationId,widget.userId,"http://10.0.3.2:8080/api/productslist","603cc4bfba5cf916fc193c79"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
              // TabBody(widget.locationId,"http://10.0.3.2:8080/api/productslist"),
            ],
          )
        
        ),
    );
}
    }
