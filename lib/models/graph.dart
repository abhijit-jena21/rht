class UserGraph {
  String x;
  int y;
  int total;

  UserGraph({this.x, this.y, this.total});

  UserGraph.fromJson(Map<String, dynamic> json) {
    x = json['name'];
    y = json['profit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.x;
    data['profit'] = this.y;
    data['total'] = this.total;
    return data;
  }
}
