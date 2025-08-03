void main(List<String> args) {
  Map<String, int> tahlil = {
    "Product A": 150,
    "Product B": 200,
    "Product C": 50,
    "Product D": 400
  };
  print(Map.fromEntries(
    tahlil.entries.where((e) => e.value >= 200),
  ));
  var filtered = [];
  tahlil.entries.forEach(
    (element) => filtered.add(element),
  );
  filtered.sort(
    (a, b) => b.value.compareTo(a.value),
  );
  print(filtered);
}
