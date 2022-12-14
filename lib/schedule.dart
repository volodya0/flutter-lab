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
    GroupSchedule groupSchedule =
        scheduleData.getScheduleForGroup(selectedGroup);

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule $selectedGroup'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: [
        Flexible(
            child: SizedBox(
                width: 400,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    DaySchedule daySchedule =
                        groupSchedule.getScheduleForDay(index);
                    List<Subject> subjects = daySchedule.getSubjects();
                    return ExpansionTile(
                        collapsedBackgroundColor:
                            const Color.fromARGB(15, 0, 0, 0),
                        backgroundColor: const Color.fromARGB(15, 0, 0, 0),
                        title: Text(daySchedule.getDayName()),
                        subtitle: Text('subjects count : ${subjects.length}'),
                        children: subjects.map((subject) {
                          int subjectOrder = subject.getOrder();
                          return ListTile(
                              subtitle: Text(
                                  scheduleData.getTimeForSubject(subjectOrder)),
                              title:
                                  Text('$subjectOrder. ${subject.getName()}'));
                        }).toList());
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ))),
        Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back')))
      ])),
    );
  }
}
