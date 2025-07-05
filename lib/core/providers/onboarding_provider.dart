import 'package:flutter/foundation.dart';
import 'package:pillar/core/models/onboarding_data.dart';
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

  Future<void> saveToStorage() async{
    //
  }
}