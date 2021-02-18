import 'package:flutter/material.dart';

import '../widgets/appbar.dart';

class Departments extends StatelessWidget {
  const Departments({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
              itemCount: data.length,
        )
        );
  }
}

class Entry {
  const Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

const List<Entry> data = <Entry>[
  Entry(
    'Appliances',
    <Entry>[
      Entry('Televisions'),
      Entry('Washing Machines'),
      Entry('Refrigerators'),
      Entry('Air Conditioners'),
      Entry('Kitchen Appliances'),
      Entry('Home Appliances'),
    ],
  ),
  Entry(
    'Electronics',
    <Entry>[
      Entry('Consoles'),
      Entry('Styling'),
      Entry('Printers'),
      Entry('Cameras'),
      Entry('Monitors & Peripherals'),
    ],
  ),
  Entry(
    'Furnitures',
    <Entry>[
      Entry('Beds'),
      Entry('Sofas'),
      Entry('Mattresses'),
      Entry('Wardrobes'),
      Entry('Dressing Table'),
      Entry('Office Chairs'),
      Entry('Office Table'),
      Entry('Dining Table'),
    ],
  ),
  Entry(
    'Fitness',
    <Entry>[
      Entry('Dumbbells'),
      Entry('Treadmills'),
      Entry('Bars'),
      Entry('Ab Exerciser'),
      Entry('Exercise Bikes'),
      Entry('Fitness Bench'),
    ],
  ),
  Entry(
    'Space Saver',
    <Entry>[
      Entry('Bean Bags'),
      Entry('Collapsible Wardrobes'),
      Entry('Cabinets'),
      Entry('Bookshelves'),
      Entry('Hammock Swings'),
    ],
  ),
  Entry(
    'Kitchen and Dining',
    <Entry>[
      Entry('Gas Stoves'),
      Entry('Kitchen Racks'),
      Entry('Microwave'),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(title: Text(root.title,style: TextStyle(fontSize: 15.0),),
    contentPadding: EdgeInsets.fromLTRB(40,0,0,0));
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title, ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
