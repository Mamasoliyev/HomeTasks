import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getProductByName(String name) async {
  final url = Uri.parse('https://fakestoreapi.com/products');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> products = jsonDecode(response.body);

      final product = products.firstWhere(
        (item) =>
            item['title'].toString().toLowerCase().contains(name.toLowerCase()),
        orElse: () => null,
      );

      if (product != null) {
        print("Mahsulot topildi:");
        print("ID: ${product['id']}");
        print("Nomi: ${product['title']}");
        print("Narxi: \$${product['price']}");
        print("Tavsifi: ${product['description']}");
        print("Rasm: ${product['image']}");
      } else {
        print("Mahsulot topilmadi.");
      }
    } else {
      print("Server xatosi: ${response.statusCode}");
    }
  } catch (e) {
    print("Xatolik yuz berdi: $e");
  }
}

void main() async {
  await getProductByName("shirt"); // Masalan: shirt, backpack, laptop
}
