import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridOne extends StatefulWidget {
  @override
  _GridOneState createState() => _GridOneState();
}

class _GridOneState extends State<GridOne> {
  Material myItems(AssetImage assetImage, String title) {
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
                    Container(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: Text(title, style: Theme.of(context).textTheme.bodyText1),
                    )
                    
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaggeredGridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            myItems(AssetImage('././assets/images/television.png'), 'Appliances'),
            myItems(AssetImage('././assets/images/speaker.png'), 'Electronics'),
            myItems(AssetImage('././assets/images/armchair.png'), 'Furniture'),
            myItems(AssetImage('././assets/images/dumbbell.png'), 'Fitness'),
            myItems(AssetImage('././assets/images/boxes.png'), 'Space Saver'),
            myItems(AssetImage('././assets/images/cutlery.png'), 'Kitchen'),
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
