import 'package:flutter/material.dart';
import 'package:pillar/core/providers/onboarding_provider.dart';
import 'package:pillar/screens/onboarding/features_pages/features_page.dart';
import 'package:pillar/screens/onboarding/user_setup_pages/project_setup_screen.dart';
import 'package:provider/provider.dart';

class UsernameSetupScreen extends StatefulWidget {
  const UsernameSetupScreen({super.key});

  @override
  State<UsernameSetupScreen> createState() => _UsernameSetupScreenState();
}

class _UsernameSetupScreenState extends State<UsernameSetupScreen> {

  TextEditingController username_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<OnboardingProvider>(context, listen: false);
      if (provider.onboardingData.username != null){
        username_controller.text = provider.onboardingData.username!;
      }
    });

    username_controller.addListener((){
      final provider = Provider.of<OnboardingProvider>(context, listen: false);
      provider.updateUsername(username_controller.text);
    });
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Let's start with your name",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: username_controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue.shade400,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => FeaturesPage()),
                      );
                    },
                    icon: Icon(Icons.info, size: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => ProjectSetupScreen(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(7.0),
                            backgroundColor: WidgetStateProperty.all(
                              Colors.blue[400],
                            ),
                            minimumSize: WidgetStateProperty.all(
                              const Size(100, 40),
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              Colors.black,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
