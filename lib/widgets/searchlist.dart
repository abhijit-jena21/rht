import 'package:flutter/material.dart';
import 'package:rht/widgets/tabbody.dart';
import '../models/product.dart';
import 'admin/adminproductcard.dart';
import '../screens/splash_screen.dart';
import '../widgets/productcard.dart';
import 'package:async/async.dart';

class SearchList extends StatefulWidget {
  final List<Product> snapshot;
  final String userId;
  // final String role;
  SearchList(this.snapshot, this.userId);
  @override
  _SearchListState createState() => _SearchListState();
}


class _SearchListState extends State<SearchList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (admin == false)
      return SingleChildScrollView(
        physics: ScrollPhysics(),
              child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 1,
            ),
            padding: EdgeInsets.all(5.0),
            itemCount: widget.snapshot.length,
            // ignore: missing_return
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                  widget.userId,
                  widget.snapshot[index].sId,
                  widget.snapshot[index].name,
                  widget.snapshot[index].img,
                  widget.snapshot[index].details,
                  widget.snapshot[index].price,
                  widget.snapshot[index].rent,
                  widget.snapshot[index].deposit,
                  widget.snapshot[index].duration,
                  widget.snapshot[index].itemsid,
                  widget.snapshot[index].stock,
                  widget.snapshot[index].locationid);
            },
          ),
      );
    else if(admin==true){
      void refresh(int index) {
        setState(() {
          widget.snapshot.removeAt(index);
        });
      }

      return SingleChildScrollView(
        physics: ScrollPhysics(),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 2.3,
            ),
            padding: EdgeInsets.all(5.0),
            itemCount: widget.snapshot.length,
            // ignore: missing_return
            itemBuilder: (BuildContext context, int index) {
              return AdminProductCard(
                  widget.snapshot[index].sId,
                  widget.snapshot[index].name,
                  widget.snapshot[index].img,
                  widget.snapshot[index].details,
                  widget.snapshot[index].price,
                  widget.snapshot[index].rent,
                  widget.snapshot[index].deposit,
                  widget.snapshot[index].duration,
                  widget.snapshot[index].itemsid,
                  widget.snapshot[index].locationid,
                  index,
                  refresh);
            },
          ),
      );
    }
  }
}
