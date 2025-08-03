abstract class Employee {
  String name;
  int age;
  Employee(this.name, this.age);
  String getDetails();
}

abstract class Course {
  String courseName;
  int duration;
  Teacher teacher;
  double price;
  List<Student> students = [];

  Course(this.courseName, this.duration, this.teacher, this.price);

  void addStudent(Student student);
  void removeStudent(Student student);
}

abstract class MalakaOshirish {
  void train();
}

abstract class DarsOtish {
  void teach();
}

class Teacher extends Employee implements MalakaOshirish, DarsOtish {
  String subject;

  Teacher(String name, int age, this.subject) : super(name, age);

  @override
  void teach() {
    print('$name $subject fanidan dars bermoqda.');
  }

  @override
  void train() {
    print('$name malaka oshiryapti.');
  }

  @override
  String getDetails() => '$name, yosh: $age, fan: $subject';
}

class Student {
  String name;
  int age;
  List<Course> enrolledCourses = [];

  Student(this.name, this.age);

  void enroll(Course course) {
    enrolledCourses.add(course);
    print('$name kursga yozildi: ${course.courseName}');
  }

  void leave(Course course) {
    enrolledCourses.remove(course);
    print('$name kursdan chiqdi: ${course.courseName}');
  }
}

class ProgrammingCourse extends Course {
  ProgrammingCourse(Teacher teacher) : super("Dasturlash", 4, teacher, 1500000);

  @override
  void addStudent(Student student) {
    students.add(student);
    student.enroll(this);
  }

  @override
  void removeStudent(Student student) {
    students.remove(student);
    student.leave(this);
  }
}

class MathCourse extends Course {
  MathCourse(Teacher teacher) : super("Matematika", 3, teacher, 1200000);

  @override
  void addStudent(Student student) {
    students.add(student);
    student.enroll(this);
  }

  @override
  void removeStudent(Student student) {
    students.remove(student);
    student.leave(this);
  }
}

class DesignCourse extends Course {
  DesignCourse(Teacher teacher) : super("Dizayn", 2, teacher, 1000000);

  @override
  void addStudent(Student student) {
    students.add(student);
    student.enroll(this);
  }

  @override
  void removeStudent(Student student) {
    students.remove(student);
    student.leave(this);
  }
}

class NajotTalim {
  String centerName;
  int openedYear;
  List<Course> courses = [];
  List<Teacher> teachers = [];

  NajotTalim(this.centerName, this.openedYear);

  void addCourse(Course course) {
    courses.add(course);
    print('${course.courseName} kursi ochildi.');
  }

  void removeCourse(Course course) {
    courses.remove(course);
    print('${course.courseName} kursi o‘chirildi.');
  }

  void addTeacher(Teacher teacher) {
    teachers.add(teacher);
    print('${teacher.name} o‘qituvchilar ro‘yxatiga qo‘shildi.');
  }

  void showSummary() {
    print('\nMarkaz: $centerName');
    print('Ochilgan yili: $openedYear');
    print('Jami kurslar: ${courses.length}');
    print('O‘qituvchilar soni: ${teachers.length}');
  }
}

void main() {
  var teacher1 = Teacher("Shaxzod", 30, "Dasturlash");
  var teacher2 = Teacher("Dilfuza", 28, "Matematika");

  var course1 = ProgrammingCourse(teacher1);
  var course2 = MathCourse(teacher2);

  var student1 = Student("Nodirbek", 23);
  var student2 = Student("Madina", 21);

  var najotTalim = NajotTalim("Najot Ta'lim", 2020);

  najotTalim.addTeacher(teacher1);
  najotTalim.addTeacher(teacher2);

  najotTalim.addCourse(course1);
  najotTalim.addCourse(course2);

  course1.addStudent(student1);
  course2.addStudent(student1);
  course2.addStudent(student2);

  najotTalim.showSummary();
}
