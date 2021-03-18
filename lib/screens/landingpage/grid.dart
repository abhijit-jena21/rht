import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../products/products.dart';
// import 'package:rht/my_navigator.dart';

class GridOne extends StatefulWidget {
  final String locationId;
  final String userId;
  final void Function(int, int, String) onButtonTapped;
  GridOne(this.locationId, this.userId, this.onButtonTapped);
  // final productsKey = new GlobalKey<_ProductsState>();
  @override
  _GridOneState createState() => _GridOneState();
}

class _GridOneState extends State<GridOne> with SingleTickerProviderStateMixin {
  int tabIndex;
  // String locationId;
  // MyNavigator myNavigator;
  Products products;
  // TabController tabController;
  @override
  // void initState() {
  //   super.initState();
  //   tabController = new TabController(vsync: this, length: 6);
  // }

  // @override
  // void dispose() {
  //   tabController.dispose();
  //   super.dispose();
  // }

  

  @override
  Widget build(BuildContext context) {
    Material myItems(AssetImage assetImage, String title, int ind) {
      Image image = Image(
        image: assetImage,
        width: 40.0,
        color: Color(0xff2873f0),
      );
      return Material(
          color: Colors.white,
          // elevation: 0.5,
          // shadowColor: Theme.of(context).primaryColor,
          // borderRadius: BorderRadius.circular(10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)), 
          side: BorderSide(width: 0.2, color: Colors.black38)
          ),
          child: InkWell(
            onTap: () {
              print('grid' + widget.userId);
              setState(() {
                tabIndex = ind;
              });
              // Navigator.pushNamed(context, 'products');
              widget.onButtonTapped(1, tabIndex, widget.locationId);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Products(
              //               index: tabIndex,
              //               locationId: widget.locationId,
              //               userId: widget.userId,
              //             )));
              print(":" + tabIndex.toString());
              print(ind);
              // // Navigator.push(
              // //     context,
              // //     MaterialPageRoute(
              // //         builder: (context) => Products.getC(
              // //             tabController: tabController, index: index)));
              // DefaultTabController.animateTo(DefaultTabController.of(context).index);
              // print(tabController.index);
              // // myNavigator.goToCategory(context);
              // // products.control();
              // // Products(key: widget.productsKey);
              // DefaultTabController.of(context).animateTo(ind);
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                          ),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: 15),
                          clipBehavior: Clip.none,
                          // width: double.infinity,
                          // constraints: BoxConstraints.expand(),
                          child: image),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(5,5,5,5),
                          child: Text(title,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black54)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));
    }

    return Column(
      children: [
        StaggeredGridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            myItems(AssetImage('././assets/images/television.png'),
                'Appliances', 0),
            myItems(
                AssetImage('././assets/images/speaker.png'), 'Electronics', 1),
            myItems(
                AssetImage('././assets/images/armchair.png'), 'Furniture', 2),
            myItems(AssetImage('././assets/images/dumbbell.png'), 'Fitness', 3),
            myItems(
                AssetImage('././assets/images/boxes.png'), 'Space Saver', 4),
            myItems(AssetImage('././assets/images/cutlery.png'), 'Kitchen', 5),
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, 100.0),
            StaggeredTile.extent(1, 100.0),
            StaggeredTile.extent(1, 100.0),
            StaggeredTile.extent(1, 100.0),
            StaggeredTile.extent(1, 100.0),
            StaggeredTile.extent(1, 100.0),
          ],
        ),
      ],
    );
  }
}
