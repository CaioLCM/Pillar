import 'package:flutter/material.dart';

class UserSetupScreen extends StatefulWidget {
  const UserSetupScreen({super.key});

  @override
  State<UserSetupScreen> createState() => _UserSetupScreenState();
}

class _UserSetupScreenState extends State<UserSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Let's start with your name", style: TextStyle(fontSize: 20),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.blue.shade400),
                  borderRadius: BorderRadius.circular(15)
                )
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ));
                    },
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(7.0),
                      backgroundColor: WidgetStateProperty.all(Colors.blue[400]),
                      minimumSize: WidgetStateProperty.all(const Size(100, 40))
                    ),
                    child: Text("Next",)
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}