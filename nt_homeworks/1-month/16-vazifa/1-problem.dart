extension Malumot on Map {
  String toliqMalumot() {
    return "${this['nomi']} - ${this['muallif']}";
  }
}

void main(List<String> args) {
  Map books = {"nomi": "Dunyo", "muallif": "Ali"};
  print(books.toliqMalumot());
}
