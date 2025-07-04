import 'package:pillar/core/models/user_data.dart';
import 'package:pillar/core/services/json_storage_service.dart';

class UserController {
  final JsonStorageService _storageService = JsonStorageService();

  Future<bool> isUserLoggedIn() async {
    return await _storageService.hasUserData();
  }

  Future<UserData?> getCurrentUser() async {
    return await _storageService.loadUserData();
  }

  Future<void> createUser(String name, String? profile_picture) async {
    if (name.trim().isEmpty){
      throw Exception("Invalid name");
    }
    UserData userData = UserData(name: name, profile_picture: profile_picture ?? "");
    await _storageService.saveUserData(userData);
  }

  Future<void> updateUser(UserData userData) async {
    await _storageService.saveUserData(userData);
  }
}