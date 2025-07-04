import 'package:flutter/material.dart';
import 'package:pillar/screens/onboarding/user_setup_pages/username_setup_screen.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.trending_up,
              size: 100,
              color: Color.fromARGB(255, 1, 85, 153),
            ),
            Text("Track your progress", style: TextStyle(fontSize: 28)),
            Text(
              "See your growth and achievements",
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 7, backgroundColor: Colors.grey[400]),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7, backgroundColor: Colors.grey[400]),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7, backgroundColor: Colors.grey[400]),
                  SizedBox(width: 5),
                  CircleAvatar(
                    radius: 7,
                    backgroundColor: Color.fromARGB(255, 1, 85, 153),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => UsernameSetupScreen()),
                );
              },
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(200, 35)),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(),
                  ),
                ),
              ),
              child: Text("Got it", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
