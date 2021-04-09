class CurrentOrders {
  String sId;
  String name;
  String phone;
  String email;
  String address;
  List<Currentorder> currentorder;

  CurrentOrders(
      {this.sId,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.currentorder});

  CurrentOrders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    if (json['currentorder'] != null) {
      // ignore: deprecated_member_use
      currentorder = new List<Currentorder>();
      json['currentorder'].forEach((v) {
        currentorder.add(new Currentorder.fromJson(v));
      });
    }
    else if (json['intransit'] != null) {
      // ignore: deprecated_member_use
      currentorder = new List<Currentorder>();
      json['intransit'].forEach((v) {
        currentorder.add(new Currentorder.fromJson(v));
      });
    }
    else if (json['pastorder'] != null) {
      // ignore: deprecated_member_use
      currentorder = new List<Currentorder>();
      json['pastorder'].forEach((v) {
        currentorder.add(new Currentorder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    if (this.currentorder != null) {
      data['currentorder'] = this.currentorder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Currentorder {
  String pId;
  String locationid;
  String checkoutdate;
  String name;
  int count;
  int deposit;
  String img;
  int duration;
  int iRent;
  String lastpaydate;
  int due;
  int monthspaid;
  String iscancelled;

  Currentorder(
      {this.pId,
      this.locationid,
      this.checkoutdate,
      this.name,
      this.count,
      this.deposit,
      this.img,
      this.duration,
      this.iRent,
      this.lastpaydate,
      this.due,
      this.monthspaid,
      this.iscancelled});

  Currentorder.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    locationid = json['locationid'];
    checkoutdate = json['checkoutdate'];
    name = json['name'];
    count = json['count'];
    deposit = json['deposit'];
    img = json['img'];
    duration = json['duration'];
    iRent = json['_rent'];
    lastpaydate = json['lastpaydate'];
    due = json['due'];
    monthspaid = json['monthspaid'];
    iscancelled = json['iscancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_id'] = this.pId;
    data['locationid'] = this.locationid;
    data['checkoutdate'] = this.checkoutdate;
    data['name'] = this.name;
    data['count'] = this.count;
    data['deposit'] = this.deposit;
    data['img'] = this.img;
    data['duration'] = this.duration;
    data['_rent'] = this.iRent;
    data['lastpaydate'] = this.lastpaydate;
    data['due'] = this.due;
    data['monthspaid'] = this.monthspaid;
    data['iscancelled'] = this.iscancelled;
    return data;
  }
}
