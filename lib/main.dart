import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/providers/shared_preference_provider.dart';
import 'package:sudoku/screens/home.dart';

// todo:
// 1. Handle the case where user finishes the sudoku correctly (Done)
// 2. Persist state
// 3. Continue button in the buttons list
// 4. Disable button to the numbers if all of them filled correctly (Done)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreference = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferenceProvider.overrideWith((ref) => sharedPreference),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
