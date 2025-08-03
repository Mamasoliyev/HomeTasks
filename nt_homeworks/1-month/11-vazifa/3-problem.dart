void main() {
  List<Map<String, dynamic>> students = [
    {'name': 'Ali', 'age': 17, 'grade': 90},
    {'name': 'Hasan', 'age': 18, 'grade': 70},
    {'name': 'Olim', 'age': 16, 'grade': 80}
  ];

  List<Map<String, dynamic>> highGrades = students.where((s) => s['grade'] >= 85).toList();
  List<Map<String, dynamic>> averageGrades = students.where((s) => s['grade'] < 85).toList();

  print("Yuqori Baholar: $highGrades");
  print("O'rtacha Baholar: $averageGrades");
}
