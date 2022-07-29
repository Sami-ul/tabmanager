class Link {
  int? id;
  String? category;
  String? link;

  Link({this.id, this.category, this.link});

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['link'] = link;
    return data;
  }

  @override
  String toString() {
    return "(ID: $id, Category: $category, Link: $link)";
  }
}
