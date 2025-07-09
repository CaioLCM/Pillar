import 'package:flutter/material.dart';
import 'package:pillar/core/models/project.dart';
import 'package:pillar/core/models/user_data.dart';
import 'package:pillar/core/services/json_storage_service.dart';
import 'package:pillar/screens/dashboard/main_app_screen.dart';
import 'package:pillar/screens/projects/create_project_page.dart';
import 'package:pillar/screens/projects/widgets/navigator_widget.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  Widget _buildProjectCard({
    required String subjectName,
    required Color color,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.2), width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subjectName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Project> userProjects = [];

  Future<void> _loadUserProjects() async {
    UserData? userData = await JsonStorageService().loadUserData();
    if(userData != null){
      setState(() {
        userProjects = userData.projects;      
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Colors.purple[700],
        elevation: 8,
        title: Center(
          child: Text(
            "Projects",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        centerTitle: true,
        leading: PopupMenuButton<String>(
          iconColor: Colors.white,
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: "Projects",
                  child: Row(
                    children: [
                      Icon(Icons.folder),
                      SizedBox(width: 10),
                      Text("Projects"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "Dashboard",
                  child: Row(
                    children: [
                      Icon(Icons.dashboard),
                      SizedBox(width: 10),
                      Text("Dashboard"),
                    ],
                  ),
                ),
              ],
          onSelected: (value) {
            switch (value) {
              case "Projects":
                break;
              case "Dashboard":
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => MainAppScreen()),
                );
                break;
            }
          },
        ),
      ), */
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: NavigatorWidget(),
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(225, 15)),
                backgroundColor: WidgetStatePropertyAll(Colors.purple),
                elevation: WidgetStatePropertyAll(5),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal()
                ))
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CreateProjectPage()));
              },
              child: Text(
                "Create new study project",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(height: 15,),
            ...userProjects.map((project) => _buildProjectCard(
              subjectName: project.name,
              color: project.color,
              icon: project.icon.icon!,
            )).toList(),
          ],
        ),
      ),
    );
  }
}
