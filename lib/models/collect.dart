class Price {
  String name;
  int price;
  int collected;
  String createdat;

  Price({this.name, this.price, this.collected, this.createdat});

  Price.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    collected = json['collected'];
    createdat = json['createdat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['collected'] = this.collected;
    data['createdat'] = this.createdat;
    return data;
  }
}