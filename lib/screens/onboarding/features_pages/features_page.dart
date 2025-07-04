import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pillar/screens/onboarding/features_pages/focus_page.dart';
import 'package:pillar/screens/onboarding/features_pages/organize_page.dart';
import 'package:pillar/screens/onboarding/features_pages/progress_page.dart';
import 'package:pillar/screens/onboarding/features_pages/welcome_page.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.purple.shade400],
          ),
        ),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
          children: [
            WelcomePage(),
            OrganizePage(),
            FocusPage(),
            ProgressPage(),
          ],
        ),
      ),
    );
  }
}
