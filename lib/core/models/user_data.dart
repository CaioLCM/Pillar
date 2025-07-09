import 'package:pillar/core/models/project.dart';

class UserData {
  String name;
  String? profileImagePath;
  String? mainGoal;
  List<Project> projects;
  DateTime createdAt = DateTime.now();
  double totalFocusHours = 0;
  int? streakGoal;
  int? dailyGoal;

  UserData({
    required this.name,
    this.mainGoal,
    this.profileImagePath = '',
    this.projects = const [],
    this.totalFocusHours = 0,
    this.dailyGoal,
    this.streakGoal,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profileImagePath": profileImagePath,
      "mainGoal": mainGoal,
      "projects": projects.map((p) => p.toJson()).toList(),
      "createdAt": createdAt.toIso8601String(),
      "totalFocusHours": totalFocusHours,
      "dailyGoal": dailyGoal,
      "streakGoal": streakGoal
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json["name"] ?? "",
      profileImagePath: json["profileImagePath"],
      mainGoal: json["mainGoal"],
      projects: (json["projects"] as List<dynamic>?)
      ?.map((p) => Project.fromJson(p)).toList() ?? [],
      createdAt: DateTime.parse(json["createdAt"]),
      totalFocusHours: json["totalFocusHours"]?.toDouble() ?? 0.0,
      dailyGoal: json["dailyGoal"],
      streakGoal: json["streakGoal"]
    );
  }
}
