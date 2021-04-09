class Demand {
  String name;
  int demand;
  String createdat;

  Demand({this.name, this.demand, this.createdat});

  Demand.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    demand = json['demand'];
    createdat = json['createdat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['demand'] = this.demand;
    data['createdat'] = this.createdat;
    return data;
  }
}