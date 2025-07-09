import 'package:flutter/material.dart';
import 'package:pillar/core/models/project.dart';
import 'package:pillar/core/models/user_data.dart';
import 'package:pillar/core/services/json_storage_service.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {

  Future<void> _saveProject() async{
    try{
      if(nameController.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a project name"))
        );
        return;
      }
      final newProject = Project(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: nameController.text,
        createdAt: DateTime.now(),
        color: selectedColor,
        icon: Icon(selectedIcon),
      );

      JsonStorageService storageService = JsonStorageService();
      UserData? userData = await storageService.loadUserData();

      if(userData != null){
        userData.projects.add(newProject);

        await storageService.saveUserData(userData);

        Navigator.of(context).pop();
      }
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error creating project: $e"), backgroundColor: Colors.red,));
    }
  }

  IconData selectedIcon = Icons.school;
  TextEditingController nameController = TextEditingController();
  Color selectedColor = Colors.red;

  Widget _buildIconOption(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIcon = icon;
        });
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  selectedIcon == icon ? Colors.purple[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedIcon == icon ? Colors.purple : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Icon(icon),
          ),
        ],
      ),
    );
  }

  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Choose an icon for your project"),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      _buildIconOption(Icons.book, "Books"),
                      _buildIconOption(Icons.calculate, "Math"),
                      _buildIconOption(Icons.science, "Science"),
                      _buildIconOption(Icons.biotech, "Quimestry"),
                      _buildIconOption(Icons.history_edu, "History"),
                      _buildIconOption(Icons.language, "Language"),
                      _buildIconOption(Icons.computer, "IT"),
                      _buildIconOption(Icons.engineering, "Engineering"),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedColor == color ? Colors.purple : Colors.grey[300]!,
                width: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Choose an color for your project"),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      _buildColorOption(Colors.red),
                      _buildColorOption(Colors.blue),
                      _buildColorOption(Colors.green),
                      _buildColorOption(Colors.yellow),
                      _buildColorOption(Colors.purple),
                      _buildColorOption(Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 800, // Dar altura suficiente para o Stack
            child: Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Create a study project",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showIconPicker();
                      },
                      child: Container(
                        width: 60, // Largura fixa
                        height: 60, // Altura fixa
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          // Centralizar o ícone
                          child: Icon(
                            selectedIcon,
                            size: 30,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: 30,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    child: Icon(Icons.edit, size: 10),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[300]!,
                                width: 1.5,
                              ),
                            ),
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            hintText: "Name",
                          ),
                          onChanged: (value) => setState(() {}),
                          controller: nameController,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => _showColorPicker(),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Container(
                                width: 50,
                                height: 20,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildProjectCard(
                            subjectName: nameController.text,
                            color: selectedColor,
                            icon: selectedIcon,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                _saveProject();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.save, color: Colors.white),
                                  Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.exit_to_app, color: Colors.white,),
                                  Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
