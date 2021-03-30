class UserProduct {
  String pId;
  String locationid;
  String img;
  String checkoutdate;
  String name;
  int count;
  int duration;
  int iRent;
  int deposit;
  String iscancelled;

  UserProduct(
      {this.pId,
      this.locationid,
      this.img,
      this.checkoutdate,
      this.name,
      this.count,
      this.duration,
      this.iRent,
      this.deposit,
      this.iscancelled});

  UserProduct.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    locationid = json['locationid'];
    img = json['img'];
    checkoutdate = json['checkoutdate'];
    name = json['name'];
    count = json['count'];
    duration = json['duration'];
    iRent = json['_rent'];
    deposit = json['deposit'];
    iscancelled = json['iscancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_id'] = this.pId;
    data['locationid'] = this.locationid;
    data['img'] = this.img;
    data['checkoutdate'] = this.checkoutdate;
    data['name'] = this.name;
    data['count'] = this.count;
    data['duration'] = this.duration;
    data['_rent'] = this.iRent;
    data['deposit'] = this.deposit;
    data['iscancelled'] = this.iscancelled;
    return data;
  }
}
