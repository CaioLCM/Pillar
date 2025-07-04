import 'package:flutter/material.dart';

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
            Icon(Icons.trending_up, size: 100, color: Colors.blue,),
            Text("Track your progress", style: TextStyle(fontSize: 28),),
            Text("See your growth and achievements", style: TextStyle(fontSize: 16),),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 7),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7, backgroundColor: Colors.grey[400]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}