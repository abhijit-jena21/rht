class Product {
  String sId;
  String subcategoryid;
  String name;
  List<String> img;
  String details;
  int price;
  int deposit; 
  int stock;
  int demand;
  int rent;
  int duration;
  int ondemand;
  List<String> itemsid;
  String locationid;

  Product(
      {this.sId,
      this.subcategoryid,
      this.name,
      this.img,
      this.details,
      this.price,
      this.deposit,
      this.stock,
      this.demand,
      this.rent,
      this.duration,
      this.ondemand,
      this.itemsid,
      this.locationid});

  Product.fromJson(Map<String, dynamic> json) { 
    sId = json['_id'];
    subcategoryid = json['subcategoryid'];
    name = json['name'];
    img = json['img'].cast<String>();
    details = json['details'];
    price = json['price'];
    deposit = json['deposit'];
    stock = json['stock'];
    demand = json['demand'];
    rent = json['rent'];
    duration = json['duration'];
    ondemand = json['ondemand'];
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
    data['deposit'] = this.deposit;
    data['stock'] = this.stock;
    data['demand'] = this.demand;
    data['rent'] = this.rent;
    data['duration'] = this.duration;
    data['ondemand'] = this.ondemand;
    data['itemsid'] = this.itemsid;
    data['locationid'] = this.locationid;
    return data;
  }
}
