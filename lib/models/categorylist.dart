class CategoryList {
  String category;
  List<Subcategory> subcategory;

  CategoryList({this.category, this.subcategory});

  CategoryList.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['subcategory'] != null) {
      // ignore: deprecated_member_use
      subcategory = new List<Subcategory>();
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  String subid;
  String name;
  String img;

  Subcategory({this.subid, this.name, this.img});

  Subcategory.fromJson(Map<String, dynamic> json) {
    subid = json['subid'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subid'] = this.subid;
    data['name'] = this.name;
    data['img'] = this.img;
    return data;
  }
}