import 'package:flutter/material.dart';

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
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
          child:
              Text('Hi, ${arguments['firstName']} ${arguments['lastName']}')),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Authorization'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  firstName = value;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'What is your first name?',
                  labelText: 'First name *',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  lastName = value;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'What is your last name?',
                  labelText: 'Last name *',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home', arguments: {
                      'firstName': firstName,
                      'lastName': lastName
                    });
                  },
                  child: const Text('Continue'))
            ],
          ),
        ));
  }
}
