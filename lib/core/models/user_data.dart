class UserData {
  String name;
  String? profileImagePath;
  String profile_picture = '';
  DateTime createdAt = DateTime.now();
  double totalFocusHours = 0;
  UserData({
    required this.name,
    this.profile_picture = '',
    this.totalFocusHours = 0,
    this.profileImagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profile_picture": profile_picture,
      "profileImagePath": profileImagePath,
      "createdAt": createdAt.toIso8601String(),
      "totalFocusHours": totalFocusHours,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json["name"] ?? "",
      profile_picture: json["profile_picture"] ?? "",
      profileImagePath: json["profileImagePath"],
      totalFocusHours: json["totalFocusHours"]?.toDouble() ?? 0.0
    );
  }
}
