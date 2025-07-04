import 'package:flutter/material.dart';

class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.psychology, size: 100, color: Colors.blue),
            Text("Stay Focused", style: TextStyle(fontSize: 28),),
            Text("Boost productivity", style: TextStyle(fontSize: 16),),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 7),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7, backgroundColor: Colors.grey[400]),
                  SizedBox(width: 5),
                  CircleAvatar(radius: 7),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
