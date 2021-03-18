class CartProduct {
  String pId;
  String locationid;
  String name;
  int count;
  int duration;
  int iRent;
  String img;
  String date;
  int deposit;

  CartProduct(
      {this.pId,
      this.locationid,
      this.name,
      this.count,
      this.duration,
      this.iRent,
      this.img,
      this.date,
      this.deposit});

  CartProduct.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    locationid = json['locationid'];
    name = json['name'];
    count = json['count'];
    duration = json['duration'];
    iRent = json['_rent'];
    img = json['img'];
    date = json['checkoutdate'];
    deposit = json['deposit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_id'] = this.pId;
    data['locationid'] = this.locationid;
    data['name'] = this.name;
    data['count'] = this.count;
    data['duration'] = this.duration;
    data['_rent'] = this.iRent;
    data['img'] = this.img;
    data['checkoutdate'] = this.date;
    data['deposit'] = this.deposit;
    return data;
  }
}
