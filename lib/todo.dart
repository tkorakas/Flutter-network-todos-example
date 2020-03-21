class Todo {
  int id;
  int userId;
  String title;
  bool completed;

  Todo({this.id, this.userId, this.title, this.completed});

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        title = json['title'],
        completed = json['completed'];
}
