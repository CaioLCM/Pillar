import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:pillar/core/models/onboarding_data.dart';
import 'package:pillar/core/models/project.dart';
import 'package:pillar/core/models/user_data.dart';
import 'package:pillar/core/services/json_storage_service.dart';
// Make sure that the file 'onboarding_data.dart' exists and defines a class named 'OnboardingData'

class OnboardingProvider extends ChangeNotifier {
  OnboardingData _onboardingData = OnboardingData();

  OnboardingData get onboardingData => _onboardingData;

  void updateUsername (String username){
    _onboardingData.username = username;
    notifyListeners();
  }

  void updateProjectName(String projectName){
    _onboardingData.projectName = projectName;
    notifyListeners();
  }

    void updateDailyGoal(int dailyGoal){
    _onboardingData.dailyGoal = dailyGoal;
    notifyListeners();
  }

    void updateStreakGoal(int streakGoal){
    _onboardingData.streakGoal = streakGoal;
    notifyListeners();
  }

  void clearData(){
    _onboardingData = OnboardingData();
    notifyListeners();
  }

  bool get isComplete {
    return _onboardingData.username != null && 
       _onboardingData.username!.isNotEmpty &&
       _onboardingData.projectName != null && 
       _onboardingData.projectName!.isNotEmpty &&
       _onboardingData.dailyGoal != null && 
       _onboardingData.streakGoal != null;
  }

  Future<bool> finishOnboarding() async {
    if (!isComplete){
      return false;
    }

    try {
      final firstProject = Project(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _onboardingData.projectName ?? "My project",
        createdAt: DateTime.now(),
        color: Colors.purple,
        icon: Icon(Icons.school),
      );

      final userData = UserData(
        name: _onboardingData.username!,
        totalFocusHours: 0.0,
        dailyGoal: _onboardingData.dailyGoal,
        streakGoal: _onboardingData.streakGoal,
        projects: [firstProject]
        );

        final jsonService = JsonStorageService();
        await jsonService.saveUserData(userData);

        clearData();

        return true;
    } catch (e) {
      print("Error to end onboarding $e");
      return false;
    }
  }

  Future<void> saveToStorage() async{
    //
  }
}