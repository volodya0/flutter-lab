import 'package:a/data.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    String selectedGroup = arguments['selectedGroup'];
    ScheduleData scheduleData = ScheduleData();
    Schedule schedule = scheduleData.getScheduleForGroup(selectedGroup);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Schedule'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                String dayName = scheduleData.getDayName(index);
                List<String> subjects = [];
                schedule.dayToSubjects[dayName]?.subjects
                    .forEach((key, value) => subjects.add(value));

                return ExpansionTile(
                    title: Text(dayName),
                    children: subjects
                        .map((value) => ListTile(title: Text(value)))
                        .toList());
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ))
          ],
        )));
  }
}
