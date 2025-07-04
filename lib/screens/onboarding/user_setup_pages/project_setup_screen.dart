import 'package:flutter/material.dart';
import 'package:pillar/screens/onboarding/user_setup_pages/goal_setup_screen.dart';
import 'package:pillar/screens/onboarding/user_setup_pages/username_setup_screen.dart';

class ProjectSetupScreen extends StatelessWidget {
  const ProjectSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController study_name_controller = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.purple.shade400],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "What's your first study project?",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: study_name_controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  hintText: "e.g., English, Programming, Math",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => GoalSetupScreen(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => UsernameSetupScreen(),
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
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
