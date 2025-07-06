import 'package:flutter/material.dart';
import 'package:pillar/core/models/user_data.dart';
import 'package:pillar/core/services/json_storage_service.dart';
import 'package:table_calendar/table_calendar.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  JsonStorageService storageService = JsonStorageService();

  Future<String> _getUserName() async {
    UserData? userData = await storageService.loadUserData();
    return userData?.name ?? "User name";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        elevation: 8,
        title: Center(
          child: Text(
            "Dashboard",
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
                  value: "dashboard",
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
                //navigator
                break;
              case "Dashboard":
                break;
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple[100]!, Colors.blue[50]!],
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(radius: 100, child: IconButton(onPressed: (){}, icon: Icon(Icons.photo_size_select_actual_rounded)),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<String>(
                        future: _getUserName(),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data ?? "User name",
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.purple[800],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard(
                      icon: Icons.access_time,
                      title: "Total hours",
                      value: "0h",
                      color: Colors.blue,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildStatCard(
                    icon: Icons.local_fire_department,
                    title: "Streak",
                    value: "0 days",
                    color: Colors.orange,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  height: 1.5,
                  color: Colors.white.withOpacity(0.5),
                ),
                Text(
                  "Progress",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    calendarFormat: CalendarFormat.month,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
