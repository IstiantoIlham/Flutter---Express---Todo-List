class TodoModel {
  int? id;
  String? title;
  String? description;

  TodoModel({this.id, this.title, this.description});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
