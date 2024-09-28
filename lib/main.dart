import 'package:demopro/components/plan.dart';
import 'package:demopro/screens/scan_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'firebase_options.dart';
import 'service/planning_permission_api.dart';


const Color primaryColor = Color(0xFF0A74DA); // Custom blue color
const Color primaryVariantColor = Color(0xFF075BB5); // A darker shade

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0D1B2A),
  // Dark blue background
  primaryColor: const Color(0xFF1B263B),
  // Same as scaffold background

  // Text Styles
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    // Slightly lighter white
    titleMedium: TextStyle(color: Colors.white, fontSize: 18),
    titleSmall: TextStyle(color: Colors.white70, fontSize: 16),
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
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF415A77), // White text on buttons
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

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    const ScanScreen(),
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
            icon: Icon(Icons.radar),
            label: 'Scan',
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
      child: FutureBuilder<Iterable<PlanningApplication>>(
        future: api.getPlansNearLocation(), // Call the API
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
            return ListView(
              children: [
                Column(
                  children: [...snapshot.data!],
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: Location().getLocation(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("No Location yet!");
            }
            return Text(snapshot.data.toString());
          }),
    );
  }
}
