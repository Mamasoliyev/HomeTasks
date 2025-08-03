import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchUsers() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);

      for (var user in users) {
        print('ID: ${user["id"]}');
        print('Name: ${user["name"]}');
        print('Email: ${user["email"]}');
        print('------------------------');
      }
    } else {
      print('Xatolik: ${response.statusCode}');
    }
  } catch (e) {
    print('Xatolik yuz berdi: $e');
  }
}

void main() async {
  await fetchUsers();
}
