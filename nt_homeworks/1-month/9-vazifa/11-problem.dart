class Course {
  String courseName;
  int enrolledStudents;
  int maxStudents;
  String teacher;

  Course(this.courseName, int? enrolledStudents, this.maxStudents, this.teacher)
      : enrolledStudents = enrolledStudents ?? 0;

  String addStudent() {
    if (enrolledStudents >= maxStudents) {
      return "Kurs to‘ldi";
    } else {
      enrolledStudents++;
      return "Yangi o'quvchi qo'shildi";
    }
  }

 
  String getCourseDetails() {
    return "Kurs nomi: $courseName\nO'qituvchi: $teacher\nO‘quvchilar soni: $enrolledStudents/$maxStudents";
  }
}
void main() {
  Course course = Course("Flutter Dasturlash", null, 3, "Aliyev Nodirbek");

  print(course.getCourseDetails());
  print(course.addStudent());
  print(course.addStudent());
  print(course.addStudent());
  print(course.addStudent());

  print("\nYangilangan ma'lumotlar:");
  print(course.getCourseDetails());
}
