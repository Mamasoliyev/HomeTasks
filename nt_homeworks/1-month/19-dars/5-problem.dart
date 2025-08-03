
import 'dart:async';

class Course {
  final String name;
  int studentsCount;

  Course(this.name, this.studentsCount);

  @override
  String toString() {
    return '$name: $studentsCount ta o\'quvchi';
  }
}

Stream<Course> incrementStudents(Stream<List<Course>> coursesStream) async* {
  await for (final courses in coursesStream) {
    for (final course in courses) {
      course.studentsCount++;

      await Future.delayed(const Duration(seconds: 1));

      yield course;
    }
  }
}

void main() async {
  final courses = [
    Course('Dart Asoslari', 10),
    Course('Flutter Dasturlash', 15),
    Course('Algoritmlar', 8),
  ];

  final coursesStream = Stream.fromIterable([courses]);

  print('Kurslardagi o\'quvchilar soni:');
  await for (final updatedCourse in incrementStudents(coursesStream)) {
    print(updatedCourse);
  }

  print('Barcha kurslar yangilandi!');
}
