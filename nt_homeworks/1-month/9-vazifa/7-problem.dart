class UserProfile {
  String name;
  String? email;
  int? age;

  // Konstruktor
  UserProfile(this.name, this.email, this.age);

  // Foydalanuvchi haqida umumiy ma'lumot qaytaradi
  String getProfileInfo() {
    String emailInfo = email ?? "Email belgilanmagan";
    String ageInfo = age?.toString() ?? "Yosh belgilanmagan";

    return "Ism: $name\nEmail: $emailInfo\nYosh: $ageInfo";
  }
}
void main() {
  UserProfile user1 = UserProfile("Nodirbek", "nodir@example.com", 23);
  print(user1.getProfileInfo());

  print("\n---\n");

  UserProfile user2 = UserProfile("Dilnoza", null, null);
  print(user2.getProfileInfo());
}
