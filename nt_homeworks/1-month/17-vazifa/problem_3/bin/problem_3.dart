import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Foydalanuvchilarni olishda xatolik');
  }
}

Future<Map<String, dynamic>> fetchJoke() async {
  final response = await http
      .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Hazilni olishda xatolik');
  }
}

Future<void> fetchData() async {
  try {
    var usersFuture = fetchUsers();
    var jokeFuture = fetchJoke();

    var users = await usersFuture;
    var joke = await jokeFuture;

    print('Foydalanuvchilar:');
    for (var user in users) {
      print('${user['name']} - ${user['email']}');
    }

    print('\nRandom Hazil:');
    print('${joke['setup']}');
    print('${joke['punchline']}');
  } catch (e) {
    print('Xatolik: $e');
  }
}

void main() {
  fetchData();
}