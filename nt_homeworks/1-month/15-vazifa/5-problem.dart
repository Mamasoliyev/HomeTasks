abstract class Person {
  String getName();
  int getAge();
}

abstract class Assignable {
  void submitAssignment();
  String getAssignmentStatus();
}

abstract class Grading {
  void gradeStudent(Student student, int grade);
}

class Student extends Person implements Assignable {
  String name;
  int age;
  String assignmentStatus = 'Not submitted';
  int? grade;

  Student({required this.name, required this.age});

  @override
  String getName() => name;

  @override
  int getAge() => age;

  void study() {
    print("$name darslarni o‘rganmoqda.");
  }

  @override
  void submitAssignment() {
    assignmentStatus = 'Submitted';
    print("$name topshiriqni topshirdi.");
  }

  @override
  String getAssignmentStatus() => assignmentStatus;
}

class Teacher extends Person implements Grading {
  String name;
  int age;

  Teacher({required this.name, required this.age});

  @override
  String getName() => name;

  @override
  int getAge() => age;

  void teach() {
    print("$name dars o‘tyapti.");
  }

  @override
  void gradeStudent(Student student, int grade) {
    if (student.assignmentStatus == 'Submitted') {
      student.grade = grade;
      print("${student.name} ga $grade baho qo‘yildi.");
    } else {
      print("${student.name} hali topshiriqni topshirmagan.");
    }
  }
}

void main() {
  Teacher teacher = Teacher(name: "Abdulla Qodiriy", age: 40);
  Student student = Student(name: "Nodirbek", age: 23);

  teacher.teach();
  student.study();

  print("Topshiriq holati: ${student.getAssignmentStatus()}");
  teacher.gradeStudent(student, 5);

  student.submitAssignment();
  print("Topshiriq holati: ${student.getAssignmentStatus()}");

  teacher.gradeStudent(student, 5); 
}
