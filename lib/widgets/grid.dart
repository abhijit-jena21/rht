import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../screens/products/products.dart';
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
  Products products;

  @override
  Widget build(BuildContext context) {
    
    Material myItems(AssetImage assetImage, String title, int ind) {
      Image image = Image(
        image: assetImage,
        width: 100.0,
        height: 70,
        fit: BoxFit.cover,
      );
      return Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)), 
          side: BorderSide(width: 0.2, color: Colors.black38)
          ),
          child: InkWell(
            onTap: () {
              print('grid' + widget.userId);
              setState(() {
                tabIndex = ind;
              });
              widget.onButtonTapped(1, tabIndex, widget.locationId);
              print(":" + tabIndex.toString());
              print(ind);
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
                          padding: EdgeInsets.all(0),
                          child: image
                          ),
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
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0, 
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            myItems(AssetImage('././assets/images/tv.jpg'),
                'Appliances', 0),
            myItems(
                AssetImage('././assets/images/speaker.jpg'), 'Electronics', 1),
            myItems(AssetImage('././assets/images/dumbbell.jpg'), 'Fitness', 2),
            myItems(
                AssetImage('././assets/images/sofa.jpg'), 'Furniture', 3),
            myItems(AssetImage('././assets/images/cutlery.jpg'), 'Kitchen', 4),
            myItems(
                AssetImage('././assets/images/rack.jpg'), 'Space Saver', 5),
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
