class UserPayment {
  String lastpaymentdate;
  String nextpaymentdate;
  int due;

  UserPayment({this.lastpaymentdate, this.nextpaymentdate, this.due});

  UserPayment.fromJson(Map<String, dynamic> json) {
    lastpaymentdate = json['lastpaymentdate'];
    nextpaymentdate = json['nextpaymentdate'];
    due = json['due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastpaymentdate'] = this.lastpaymentdate;
    data['nextpaymentdate'] = this.nextpaymentdate;
    data['due'] = this.due;
    return data;
  }
}