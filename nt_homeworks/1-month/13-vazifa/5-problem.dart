void main(List<String> args) {
  var peoples = [
    ["Asror", 23, "Jannat"],
    ["Nodirbek", 21, "Saxovat"],
    ["Ulug'bek", 22, "Firdavs"],
    ["Abdulloh", 25, "Jannat"],
    ["Otabek", 20, "Firdavs"]
  ];
  peoples.sort(
    (a, b) => (a[1] as int).compareTo((b[1] as int)),
  );
  print(peoples);

  Map<String, List<String>> grouped = {};

  for (var person in peoples) {
    String name = person[0] as String;
    String wish = person[2] as String;

    grouped.putIfAbsent(wish, () => []);
    grouped[wish]!.add(name);
  }

  print("Xohishlar bo‘yicha guruhlar:");
  grouped.forEach((wish, names) {
    print("$wish: ${names.length} ta odam (${names.join(', ')})");
  });
}
