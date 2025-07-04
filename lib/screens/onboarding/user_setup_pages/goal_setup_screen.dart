import 'package:flutter/material.dart';
import 'package:pillar/screens/onboarding/user_setup_pages/project_setup_screen.dart';

class GoalSetupScreen extends StatefulWidget {
  const GoalSetupScreen({super.key});

  @override
  State<GoalSetupScreen> createState() => _GoalSetupScreenState();
}

class _GoalSetupScreenState extends State<GoalSetupScreen> {
  @override
  Widget build(BuildContext context) {
    double _dailyHours = 0;
    double _dailyMinutes = 0;
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
                "How many hours do you want to study daily?",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slider(
                  value: _dailyHours,
                  min: 0.0,
                  max: 8.0,
                  divisions: 8,
                  label: "${_dailyHours.toStringAsFixed(1)} hours",
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.3), 
                  onChanged: (value) => _dailyHours = value)
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => ProjectSetupScreen()),
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
                            /* Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => ProjectSetupScreen(),
                              ),
                            ); */
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