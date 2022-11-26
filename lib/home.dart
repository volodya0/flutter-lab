import 'dart:ui';

import 'package:flutter/material.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String firstName;
  late String lastName;
  late List<String> groups;
  String? selectedGroup;

  _HomePageState() {
    ScheduleData scheduleData = ScheduleData();
    groups = scheduleData.getGroupsNames();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    setState(() {
      firstName = arguments['firstName'];
      lastName = arguments['lastName'];
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 26, 0, 6),
            child: Text('Hi, $firstName $lastName'),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  value: selectedGroup,
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xff000000)),
                  decoration: const InputDecoration(
                      labelText: 'Choose your group',
                      contentPadding: EdgeInsets.all(5)),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: groups
                      .map((group) => DropdownMenuItem(
                            value: group,
                            child: Text(group),
                          ))
                      .toList(),
                  onChanged: (String? newGroup) {
                    setState(() {
                      selectedGroup = newGroup;
                    });
                  },
                ),
              )),
          selectedGroup == null
              ? const SizedBox.shrink()
              : ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/schedule',
                        arguments: {'selectedGroup': selectedGroup});
                  },
                  child: const Text('Go to schedule'),
                )
        ])));
  }
}
