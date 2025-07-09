import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pillar/core/models/user_data.dart';
import 'package:pillar/core/services/json_storage_service.dart';
import 'package:pillar/screens/personalInfo/widgets/navigator_widget.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _strikeController = TextEditingController();
  TextEditingController _goalController = TextEditingController();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  JsonStorageService storageService = JsonStorageService();

  Future<void> _saveUserData() async {
    try {
      UserData? userData = await storageService.loadUserData();
      if (userData != null) {
        userData.name = _nameController.text;
        userData.dailyGoal = int.tryParse(_hoursController.text);
        userData.streakGoal = int.tryParse(_strikeController.text);
        userData.mainGoal = _goalController.text;

        await storageService.saveUserData(userData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data saved with success!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Error to save new info: $e");
    }
  }

  Future<String> _getUserName() async {
    UserData? userData = await storageService.loadUserData();
    return userData?.name ?? "User name";
  }

  Future<void> _loadUserData() async {
    try {
      UserData? userData = await storageService.loadUserData();

      if (userData != null) {
        setState(() {
          _nameController.text = userData.name;
          _hoursController.text = userData.dailyGoal?.toString() ?? "";
          _strikeController.text = userData.streakGoal?.toString() ?? "";
          _goalController.text = userData.mainGoal ?? "";
        });
      }
    } catch (e) {
      print("Error to load data: $e");
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 85,
      );
      if (image != null) {
        String? savedPath = await _saveImageToAppDirectory(File(image.path));

        if (savedPath != null) {
          setState(() {
            _profileImage = File(savedPath);
          });
        }

        await _saveProfileImagePath(savedPath!);

        Navigator.pop(context);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Profile picture saved")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error to open the camera")));
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 85,
      );
      if (image != null) {
        String? savedPath = await _saveImageToAppDirectory(File(image.path));

        setState(() {
          _profileImage = File(savedPath!);
        });

        await _saveProfileImagePath(savedPath!);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Profile picture saved")));

        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error to open galery")));
    }
  }

  Future<String?> _saveImageToAppDirectory(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newPath = '${directory.path}/$fileName';

      final savedImage = await imageFile.copy(newPath);

      return savedImage.path;
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveProfileImagePath(String imagePath) async {
    try {
      UserData? userData = await storageService.loadUserData();

      if (userData != null) {
        userData.profileImagePath = imagePath;

        await storageService.saveUserData(userData);

        print("Image saved");
      }
    } catch (e) {
      print("Error to save image");
    }
  }

  Future<void> _loadSavedProfileImage() async {
    try {
      UserData? userData = await storageService.loadUserData();

      if (userData != null && userData.profileImagePath != null) {
        File imageFile = File(userData.profileImagePath!);

        if (await imageFile.exists()) {
          setState(() {
            _profileImage = imageFile;
          });
        }
      }
    } catch (e) {
      print("Eror to load image");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedProfileImage();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[100]!, Colors.blue[50]!],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: NavigatorWidget(),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 660,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.purple[100]!, Colors.blue[50]!],
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              _profileImage == null
                                  ? null
                                  : FileImage(_profileImage!),
                          radius: 100,
                          child:
                              _profileImage == null ? Icon(Icons.person) : null,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 350,
                    child: IconButton(
                      onPressed: () async{
                        await _saveUserData();
                      },
                      icon: Icon(Icons.save, color: Colors.purple, size: 30),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 260,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder:
                                  (context) => Container(
                                    height: 130,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _pickImageFromCamera();
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 30,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _pickImageFromGallery();
                                          },
                                          icon: Icon(
                                            Icons.folder_copy,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                          icon: Icon(
                            Icons.photo_size_select_actual_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name", style: TextStyle(fontSize: 15)),
                              SizedBox(height: 5),
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
                                controller: _nameController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hours per day",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 5),
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
                                  hintText: "Hours per day",
                                ),
                                controller: _hoursController,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Strike days goal",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 5),
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
                                  hintText: "Strike days",
                                ),
                                controller: _strikeController,
                                keyboardType: TextInputType.number,
                              ),
                            ],
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            minLines: 5,
                            maxLines: 10,
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
                              hintText: "Main goal 💪",
                            ),
                            controller: _goalController,
                          ),
                        ),
                      ],
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
}
