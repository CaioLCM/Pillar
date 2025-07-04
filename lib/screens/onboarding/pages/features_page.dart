import 'package:flutter/material.dart';
import 'package:pillar/screens/onboarding/pages/focus_page.dart';
import 'package:pillar/screens/onboarding/pages/organize_page.dart';
import 'package:pillar/screens/onboarding/pages/progress_page.dart';
import 'package:pillar/screens/onboarding/pages/welcome_page.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: [WelcomePage(), OrganizePage(), FocusPage(), ProgressPage()],
      ),
    );
  }
}
