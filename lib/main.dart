import 'dart:convert';

import 'package:demopro/components/plan.dart';
import 'package:demopro/model/JsonPlan/json_plan.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

import 'service/planning_permission_api.dart';

const Color primaryColor = Color(0xFF0A74DA); // Custom blue color
const Color primaryVariantColor = Color(0xFF075BB5); // A darker shade

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0D1B2A),
  // Dark blue background
  primaryColor: const Color(0xFF1B263B),
  // Dark blue primary color
  backgroundColor: const Color(0xFF0D1B2A),
  // Same as scaffold background

  // Text Styles
  textTheme: const TextTheme(
    headline1: TextStyle(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    headline2: TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
    bodyText1: TextStyle(color: Colors.white, fontSize: 16),
    bodyText2: TextStyle(color: Colors.white70, fontSize: 14),
    // Slightly lighter white
    subtitle1: TextStyle(color: Colors.white, fontSize: 18),
    subtitle2: TextStyle(color: Colors.white70, fontSize: 16),
  ),

  // Icon Theme
  iconTheme: const IconThemeData(
    color: Colors.white, // White icons
  ),

  // App Bar
  appBarTheme: const AppBarTheme(
    color: Color(0xFF1B263B), // Darker blue for app bar
    iconTheme: IconThemeData(
      color: Colors.white, // White icons in the app bar
    ),
    titleTextStyle: TextStyle(
      color: Colors.white, // White app bar title text
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Elevated Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xFF415A77), // Lighter blue for buttons
      onPrimary: Colors.white, // White text on buttons
    ),
  ),

  // Floating Action Button
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF415A77), // Lighter blue
    foregroundColor: Colors.white, // White icon in FAB
  ),

  // Input Decorations (for TextFields)
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1B263B),
    // Darker blue input field background
    hintStyle: TextStyle(color: Colors.white70),
    // Lighter white hint text
    labelStyle: TextStyle(color: Colors.white),
    // White label text
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white), // White border when focused
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.white54), // Lighter white border when not focused
    ),
  ),

  // Bottom Navigation Bar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1B263B), // Dark blue background
    selectedItemColor: Colors.white, // White for selected item
    unselectedItemColor: Colors.white54, // Lighter white for unselected items
  ),

  // Slider theme
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.white,
    inactiveTrackColor: Colors.white24,
    thumbColor: Colors.white,
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planner Scanner',
      theme: appTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ProfileScreen(),
    HomeScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Activity',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final PlanningPermissionApi api = PlanningPermissionApi();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Response>(
        future: api.searchPlanningData(), // Call the API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Error state
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            // No data state
            return const Center(child: Text('No data found'));
          } else {
            // Success: display data
            var utf8Body = utf8.decode(snapshot.data!.bodyBytes);
            var myMap = jsonDecode(utf8Body) as List<dynamic>;
            var jsonPlans = myMap.map((e) => JsonPlan.fromJson(e));
            print(jsonPlans.first.address);
            var rows = jsonPlans.map((e) => Plan(
                  address: e.address ?? "No address",
                  reference: e.refval!,
                  status: e.dcstat!,
                  dataReceived: e.dateactcom?.toString() ?? "No date",
                  proposal: e.proposal!,
                ));

            return ListView(
              children: [
                Column(
                  children: [...rows],
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Hi"),
    );
  }
}
