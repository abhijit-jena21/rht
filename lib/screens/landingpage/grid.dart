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
        width: 50.0,
        color: Theme.of(context).primaryColor,
      );
      return Material(
          color: Colors.white,
          elevation: 2.0,
          shadowColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.0),
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
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        image,
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Text(title,
                              style: Theme.of(context).textTheme.bodyText1),
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
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
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
