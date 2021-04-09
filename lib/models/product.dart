class ProductPage {
  String page;
  String islastpage;
  List<Product> products;

  ProductPage({this.page, this.islastpage, this.products});

  ProductPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    islastpage = json['islastpage'];
    if (json['products'] != null) {
      // ignore: deprecated_member_use
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['islastpage'] = this.islastpage;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product{
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
  int stock;
  int deposit;

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
      this.locationid,
      this.stock,
      this.deposit});

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
    stock = json['stock'];
    deposit = json['deposit'];
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
    data['stock'] = this.stock;
    data['deposit'] = this.deposit;
    return data;
  }
}