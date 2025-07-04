import 'package:flutter/material.dart';
import 'package:pillar/controllers/user_controller.dart';
import 'package:pillar/screens/dashboard/main_app_screen.dart';
import 'package:pillar/screens/home/widgets/loading_widget.dart';
import 'package:pillar/screens/onboarding/pages/features_page.dart';
import 'package:pillar/screens/onboarding/pages/welcome_page.dart';
import 'package:pillar/screens/onboarding/user_setup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserController userController = UserController();

  Future<bool> _UserIsLogged() async {
    return await userController.isUserLoggedIn();
  }

  _NavigatorHandle(bool isLoggedIn) {
    isLoggedIn
        ? Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => MainAppScreen()))
        : Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => FeaturesPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _UserIsLogged(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _NavigatorHandle(snapshot.data!);
            });
            return SizedBox.shrink();
          } else if (snapshot.hasError) {
            return Center(child: Text("Error to load!!!"));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
