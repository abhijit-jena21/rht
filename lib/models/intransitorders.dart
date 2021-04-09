class IntransitOrders {
  String sId;
  List<Intransit> intransit;

  IntransitOrders({this.sId, this.intransit});

  IntransitOrders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['intransit'] != null) {
      // ignore: deprecated_member_use
      intransit = new List<Intransit>();
      json['intransit'].forEach((v) {
        intransit.add(new Intransit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.intransit != null) {
      data['intransit'] = this.intransit.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Intransit {
  String pId;
  String locationid;
  String img;
  String checkoutdate;
  String name;
  int count;
  int duration;
  int iRent;
  String lastpaydate;

  Intransit(
      {this.pId,
      this.locationid,
      this.img,
      this.checkoutdate,
      this.name,
      this.count,
      this.duration,
      this.iRent,
      this.lastpaydate});

  Intransit.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    locationid = json['locationid'];
    img = json['img'];
    checkoutdate = json['checkoutdate'];
    name = json['name'];
    count = json['count'];
    duration = json['duration'];
    iRent = json['_rent'];
    lastpaydate = json['lastpaydate'];
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
    data['lastpaydate'] = this.lastpaydate;
    return data;
  }
}