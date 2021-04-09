class Graph {
  String name;
  int paid;
  int payable;
  int due;
  int totalRent;
  int profit;
  int totalPrice;
  String lastpaymentdate;
  String nextpaymentdate;

  Graph({
    this.name,
    this.paid,
    this.payable,
    this.due,
    this.totalRent,
    this.profit,
    this.totalPrice,
    this.lastpaymentdate,
    this.nextpaymentdate
  });

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        name: json["name"],
        paid: json["paid"],
        payable: json["payable"],
        due: json["due"],
        totalRent: json["totalRent"],
        profit: json["profit"],
        totalPrice: json["totalPrice"],
        lastpaymentdate: json["lastpaymentdate"],
        nextpaymentdate: json["nextpaymentdate"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "paid": paid,
        "payable": payable,
        "due": due,
        "totalRent": totalRent,
        "profit": profit,
        "totalPrice": totalPrice,
        "lastpaymentdate": lastpaymentdate,
        "nextpaymentdate": nextpaymentdate
      };
}
