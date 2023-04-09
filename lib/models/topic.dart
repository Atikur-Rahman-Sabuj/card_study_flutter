class Topic {
  int? id;
  int? parentId;
  late String title;
  late String description;
  late bool favorite;
  late int priority;
  String? createdAt;

  Topic({
    this.id,
    this.parentId,
    required this.title,
    required this.description,
    required this.favorite,
    required this.priority,
    this.createdAt,
  });

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parentId'];
    title = json['title'];
    description = json['description'];
    favorite = json['favorite'] == 1;
    priority = json['priority'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parentId'] = parentId;
    data['title'] = title;
    data['description'] = description;
    data['favorite'] = favorite;
    data['priority'] = priority;
    data['createdAt'] = createdAt;
    return data;
  }
}
