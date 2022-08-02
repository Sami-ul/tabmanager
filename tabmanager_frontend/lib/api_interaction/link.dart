class Link {
  int? id;
  String? category;
  String? link;
  String? title;

  Link({this.id, this.title, this.category, this.link});

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['link'] = link;
    data['title'] = title;
    return data;
  }

  @override
  String toString() {
    return "(ID: $id, Title: $title, Category: $category, Link: $link)";
  }
}
