import 'package:a/schedule.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Application',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthPage(),
          '/home': (context) => const HomePage(),
          '/schedule': (context) => const SchedulePage(),
        });
  }
}
