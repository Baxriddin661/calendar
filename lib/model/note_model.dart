class NoteModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String time;
  final String priority;

  NoteModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.time,
      required this.location,
      required this.priority});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        id: json['id'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        time: json['time'] ?? "",
        location: json['location'] ?? "",
        priority: json['priority'] ?? "");
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['location'] = location;
    map['time'] = time;
    map['priority'] = priority;

    return map;
  }
}
