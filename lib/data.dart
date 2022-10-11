enum Day {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

class Subject {
  Subject(this._subjectRaw);
  final Map _subjectRaw;

  String getName() {
    return _subjectRaw['name'];
  }

  int getOrder() {
    return _subjectRaw['order'];
  }

  String? getLink() {
    return _subjectRaw['link'];
  }
}

class DaySchedule {
  DaySchedule(this._dayScheduleRaw);
  final Map _dayScheduleRaw;

  String getDayIndex() {
    return _dayScheduleRaw['day'];
  }

  String getDayName() {
    String name = Day.values[_dayScheduleRaw['day']].name;
    return name[0].toUpperCase() + name.substring(1);
  }

  List<Subject> getSubjects() {
    List<Subject> subjects =
        (_dayScheduleRaw['subjects'] as List).map((s) => Subject(s)).toList();
    subjects.sort((s1, s2) => s1.getOrder() - s2.getOrder());
    return subjects;
  }
}

class GroupSchedule {
  GroupSchedule(this._groupScheduleRaw);
  final List _groupScheduleRaw;

  DaySchedule getScheduleForDay(int dayIndex) {
    return DaySchedule(_groupScheduleRaw[dayIndex]);
  }
}

class ScheduleData {
  ScheduleData();

  List<String> getGroupsNames() {
    return _dataRaw.keys.toList() as List<String>;
  }

  GroupSchedule getScheduleForGroup(String groupName) {
    return GroupSchedule(_dataRaw[groupName]!);
  }

  final Map<String, List> _dataRaw = {
    "KI-48": [
      {
        'day': 1,
        'subjects': [
          {'name': 'Math', 'order': 1, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 2,
        'subjects': [
          {'name': 'Programming', 'order': 3, 'link': 'fakeLink'},
          {'name': 'Math', 'order': 4, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 3,
        'subjects': [
          {'name': 'Testing', 'order': 6, 'link': 'fakeLink'},
          {'name': 'Math', 'order': 4, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 4,
        'subjects': [
          {'name': 'Testing', 'order': 6, 'link': 'fakeLink'},
          {'name': 'Math', 'order': 4, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 5,
        'subjects': [
          {'name': 'Math', 'order': 1, 'link': 'fakeLink'}
        ]
      },
    ],
    "KI-47": [
      {
        'day': 1,
        'subjects': [
          {'name': 'Math', 'order': 1, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 2,
        'subjects': [
          {'name': 'Programming', 'order': 3, 'link': 'fakeLink'},
          {'name': 'Math', 'order': 4, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 3,
        'subjects': [
          {'name': 'Testing', 'order': 6, 'link': 'fakeLink'},
          {'name': 'Math', 'order': 4, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 4,
        'subjects': [
          {'name': 'Testing', 'order': 6, 'link': 'fakeLink'},
          {'name': 'Math', 'order': 4, 'link': 'fakeLink'}
        ]
      },
      {
        'day': 5,
        'subjects': [
          {'name': 'Math', 'order': 1, 'link': 'fakeLink'}
        ]
      },
    ],
  };
}
