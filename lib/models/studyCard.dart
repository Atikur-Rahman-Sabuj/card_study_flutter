class StudyCard {
  int? id;
  int? topicId;
  late String frontTitle;
  late String backTitle;
  late String frontDescription;
  late String backDescription;
  late bool favorite;
  late int priority;
  String? createdAt;

  StudyCard({
    this.id,
    this.topicId,
    required this.frontTitle,
    required this.backTitle,
    required this.frontDescription,
    required this.backDescription,
    required this.favorite,
    required this.priority,
    this.createdAt,
  });

  StudyCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicId = json['topicId'];
    frontTitle = json['frontTitle'];
    backTitle = json['backTitle'];
    frontDescription = json['frontDescription'];
    backDescription = json['backDescription'];
    favorite = json['favorite'] == 1;
    priority = json['priority'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topicId'] = topicId;
    data['frontTitle'] = frontTitle;
    data['backTitle'] = backTitle;
    data['frontDescription'] = frontDescription;
    data['backDescription'] = backDescription;
    data['favorite'] = favorite;
    data['priority'] = priority;
    data['createdAt'] = createdAt;
    return data;
  }
}
