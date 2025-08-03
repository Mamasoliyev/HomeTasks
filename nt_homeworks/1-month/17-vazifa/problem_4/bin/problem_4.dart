import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<Map<String, List<String>>> checkUserIfMaleOrFemale() async {
  final response =
      await http.get(Uri.parse('https://randomuser.me/api/?results=5000'));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    var users = data['results'];

    List<String> maleUsers = [];
    List<String> femaleUsers = [];

    for (var user in users) {
      if (user['gender'] == 'male') {
        maleUsers.add(
            user['name']['first']); 
      } else if (user['gender'] == 'female') {
        femaleUsers.add(
            user['name']['first']); 
      }
    }

    return {
      'male': maleUsers,
      'female': femaleUsers,
    };
  } else {
    throw Exception('Foydalanuvchilarni olishda xatolik');
  }
}

Future<void> getUsers() async {
  try {
    var users = await checkUserIfMaleOrFemale();

    print('Erkak foydalanuvchilar:');
    users['male']?.forEach((user) {
      print(user);
    });

    print('\nAyol foydalanuvchilar:');
    users['female']?.forEach((user) {
      print(user);
    });
  } catch (e) {
    print('Xatolik: $e');
  }
}

void main() {
  getUsers();
}
