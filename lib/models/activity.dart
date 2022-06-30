class Activity {
  int? id;
  String? name;
  String? description;

  Activity({this.id, this.name, this.description});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id : json['id'],
    name : json['name'],
    description : json['description']

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}


