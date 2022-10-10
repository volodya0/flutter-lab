class Subjects {
  Subjects(this.subjects);
  Map<int, String> subjects;
}

class Schedule {
  Schedule(Map<String, Map<int, String>> scheduleRaw) {
    scheduleRaw.forEach((key, value) => dayToSubjects[key] = Subjects(value));
  }
  Map<String, Subjects> dayToSubjects = {};
}

class ScheduleData {
  ScheduleData() {
    groupToSchedule = {};
    dataRaw.forEach((key, value) => groupToSchedule[key] = Schedule(value));
  }

  Map<String, Schedule> groupToSchedule = {};

  List<String> getGroupsNames() {
    return groupToSchedule.keys.toList();
  }

  Schedule getScheduleForGroup(String groupName) {
    return groupToSchedule[groupName]!;
  }

  String getDayName(int dayIndex) {
    switch (dayIndex) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      default:
    }
    return '';
  }
}

Map<String, Map<String, Map<int, String>>> dataRaw = {
  "KI-48": {
    "Monday": {1: 'Math', 3: 'Programming'},
    "Tuesday": {3: 'Programming'},
    "Wednesday": {1: 'Math', 3: 'Programming'},
    "Thursday": {1: 'Math', 3: 'Databases'},
    "Friday": {1: 'Testing', 3: 'Programming'},
  },
  "KI-47": {
    "Monday": {1: 'Math', 3: 'Programming'},
    "Tuesday": {3: 'Programming'},
    "Wednesday": {1: 'Databases', 3: 'Programming'},
    "Thursday": {1: 'Math'},
    "Friday": {1: 'Testing', 3: 'Programming'},
  },
};
