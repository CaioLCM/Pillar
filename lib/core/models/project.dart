import 'package:flutter/widgets.dart';

class Project {
  String id;
  String name;
  DateTime createdAt;
  DateTime? lastAccessed;
  Color color;
  Icon icon;

  Project({
    required this.id,
    required this.name,
    required this.createdAt,
    this.lastAccessed,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "createdAt": createdAt.toIso8601String(),
      "lastAccessed": lastAccessed?.toIso8601String(),
      "color": color.value.toString(),
      "iconName": icon.icon?.codePoint.toString(),
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["createdAt"]),
      lastAccessed: json["lastAccessed"] != null? DateTime.parse(json["lastAccessed"]) : null,
      color: Color(int.parse(json["color"])),
      icon: Icon(IconData(int.parse(json["iconName"]), fontFamily: 'MaterialIcons')),
    );
  }
}
