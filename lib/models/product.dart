// class Product {
//   String sId;
//   String subcategoryid;
//   String name;
//   String img;
//   String details;
//   int price;
//   int rent;
//   int duration;
//   List<String> itemsid;
//   String locationid;

//   Product(
//       {this.sId,
//       this.subcategoryid,
//       this.name,
//       this.img,
//       this.details,
//       this.price,
//       this.rent,
//       this.duration,
//       this.itemsid,
//       this.locationid});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//     sId : json['_id'],
//     subcategoryid : json['subcategoryid'],
//     name : json['name'],
//     img : json['img'],
//     details : json['details'],
//     price : json['price'],
//     rent : json['rent'],
//     duration : json['duration'],
//     itemsid : json['itemsid'].cast<String>(),
//     locationid : json['locationid'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['subcategoryid'] = this.subcategoryid;
//     data['name'] = this.name;
//     data['img'] = this.img;
//     data['details'] = this.details;
//     data['price'] = this.price;
//     data['rent'] = this.rent;
//     data['duration'] = this.duration;
//     data['itemsid'] = this.itemsid;
//     data['locationid'] = this.locationid;
//     return data;
//   }
// }

// class Product {
//   List<Arr> arr;

//   Product({this.arr});

//   Product.fromJson(Map<String, dynamic> json) {
//     if (json['arr'] != null) {
//       arr = new List<Arr>();
//       json['arr'].forEach((v) {
//         arr.add(new Arr.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.arr != null) {
//       data['arr'] = this.arr.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Arr {
//   String sId;
//   String subcategoryid;
//   String name;
//   String img;
//   String details;
//   int price;
//   int rent;
//   int duration;
//   List<String> itemsid;
//   String locationid;

//   Arr(
//       {this.sId,
//       this.subcategoryid,
//       this.name,
//       this.img,
//       this.details,
//       this.price,
//       this.rent,
//       this.duration,
//       this.itemsid,
//       this.locationid});

//   Arr.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     subcategoryid = json['subcategoryid'];
//     name = json['name'];
//     img = json['img'];
//     details = json['details'];
//     price = json['price'];
//     rent = json['rent'];
//     duration = json['duration'];
//     itemsid = json['itemsid'].cast<String>();
//     locationid = json['locationid'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['subcategoryid'] = this.subcategoryid;
//     data['name'] = this.name;
//     data['img'] = this.img;
//     data['details'] = this.details;
//     data['price'] = this.price;
//     data['rent'] = this.rent;
//     data['duration'] = this.duration;
//     data['itemsid'] = this.itemsid;
//     data['locationid'] = this.locationid;
//     return data;
//   }
// }


class Product {
  String sId;
  String subcategoryid;
  String name;
  List<String> img;
  String details;
  int price;
  int rent;
  int duration;
  List<String> itemsid;
  String locationid;

  Product(
      {this.sId,
      this.subcategoryid,
      this.name,
      this.img,
      this.details,
      this.price,
      this.rent,
      this.duration,
      this.itemsid,
      this.locationid});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subcategoryid = json['subcategoryid'];
    name = json['name'];
    img = json['img'].cast<String>();
    details = json['details'];
    price = json['price'];
    rent = json['rent'];
    duration = json['duration'];
    itemsid = json['itemsid'].cast<String>();
    locationid = json['locationid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['subcategoryid'] = this.subcategoryid;
    data['name'] = this.name;
    data['img'] = this.img;
    data['details'] = this.details;
    data['price'] = this.price;
    data['rent'] = this.rent;
    data['duration'] = this.duration;
    data['itemsid'] = this.itemsid;
    data['locationid'] = this.locationid;
    return data;
  }
}



