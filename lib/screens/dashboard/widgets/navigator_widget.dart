import 'package:flutter/material.dart';
import 'package:pillar/screens/personalInfo/personal_info_page.dart';
import 'package:pillar/screens/projects/projects_page.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 2)
          )
        ]
      ),
       height: 50,
       width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.leaderboard, color: Colors.white,)),
          IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ProjectsPage()));
          }, icon: Icon(Icons.school_outlined, color: Colors.white,)),
          IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PersonalInfoPage()));
          }, icon: Icon(Icons.person_2_outlined, color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.settings_outlined, color: Colors.white,))
        ],
      ),
    );
  }
}