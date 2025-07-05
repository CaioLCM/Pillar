import 'package:flutter/material.dart';
import 'package:pillar/core/providers/onboarding_provider.dart';
import 'package:pillar/screens/onboarding/user_setup_pages/goal_setup_screen.dart';
import 'package:provider/provider.dart';

class StrikedaysSetupScreen extends StatefulWidget {
  const StrikedaysSetupScreen({super.key});

  @override
  State<StrikedaysSetupScreen> createState() => _StrikedaysSetupState();
}

class _StrikedaysSetupState extends State<StrikedaysSetupScreen> {
  Color day1 = Colors.red[400]!;
  Color day3 = Colors.red[400]!;
  Color day5 = Colors.red[400]!;

  Color week1 = Colors.yellow[400]!;
  Color week2 = Colors.yellow[400]!;
  Color week3 = Colors.yellow[400]!;

  Color month = Colors.green[400]!;

  int? selectedDays;
  String? selectedOption;

  String _getOptionFromDays(int days) {
  switch (days) {
    case 1: return "1 day";
    case 3: return "3 days";
    case 5: return "5 days";
    case 7: return "1 week";
    case 14: return "2 weeks";
    case 21: return "3 weeks";
    case 28: return "1 month";
    default: return "1 day";
  }
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<OnboardingProvider>(context, listen: false);
      if (provider.onboardingData.streakGoal != null){
        setState(() {
          int savedDays = provider.onboardingData.streakGoal!;
          String savedOption = _getOptionFromDays(savedDays);
          _selectOption(savedDays, savedOption);
        });
      }
    });
  }

  void _selectOption(int days, String option) {
    setState(() {
      day1 = Colors.red[400]!;
      day3 = Colors.red[400]!;
      day5 = Colors.red[400]!;

      week1 = Colors.yellow[400]!;
      week2 = Colors.yellow[400]!;
      week3 = Colors.yellow[400]!;

      month = Colors.green[400]!;

      selectedDays = days;
      selectedOption = option;

      if (option == "1 day") day1 = Colors.blue[400]!;
      if (option == "3 days") day3 = Colors.blue[400]!;
      if (option == "5 days") day5 = Colors.blue[400]!;
      if (option == "1 week") week1 = Colors.blue[400]!;
      if (option == "2 weeks") week2 = Colors.blue[400]!;
      if (option == "3 weeks") week3 = Colors.blue[400]!;
      if (option == "1 month") month = Colors.blue[400]!;

      final provider = Provider.of<OnboardingProvider>(context, listen: false);
      provider.updateStreakGoal(days);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                "Strike days goal",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),

              SizedBox(height: 30),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _selectOption(1, "1 day");
                          },
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(7.0),
                            backgroundColor: WidgetStateProperty.all(day1),
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
                          child: Text("1 day"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectOption(3, "3 days");
                          },
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(7.0),
                            backgroundColor: WidgetStateProperty.all(day3),
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
                          child: Text("3 days"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectOption(5, "5 days");
                          },
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(7.0),
                            backgroundColor: WidgetStateProperty.all(day5),
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
                          child: Text("5 days"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _selectOption(7, "1 week");
                          },
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(7.0),
                            backgroundColor: WidgetStateProperty.all(week1),
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
                          child: Text("1 week"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectOption(14, "2 weeks");
                          },
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(7.0),
                            backgroundColor: WidgetStateProperty.all(week2),
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
                          child: Text("2 weeks"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectOption(21, "3 weeks");
                          },
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(7.0),
                            backgroundColor: WidgetStateProperty.all(week3),
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
                          child: Text("3 weeks"),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectOption(28, "1 month");
                      },
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(7.0),
                        backgroundColor: WidgetStateProperty.all(month),
                        minimumSize: WidgetStateProperty.all(
                          const Size(100, 40),
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text("1 month"),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => GoalSetupScreen(),
                              ),
                            );
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
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ],
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
                              Colors.green,
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
                          child: Icon(Icons.done, color: Colors.white),
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
