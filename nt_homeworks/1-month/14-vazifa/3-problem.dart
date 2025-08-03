// ignore_for_file: public_member_api_docs, sort_constructors_first

void main() {
  Professor professor = Professor(
    kafedraNomi: "Kompyuter Ilmlari",
    rahbar: "Prof. Karimov",
    kurslar: ["Sun’iy intellekt", "Ma’lumotlar tuzilmasi"],
    ism: "Nodirbek",
    ilmiyUnvon: "PhD",
  );

  professor.getDepartmentInfo();
  professor.teach();
  professor.research();
  professor.publish();
}

class Kafedra {
  String kafedraNomi;
  String rahbar;
  List<String> kurslar;

  Kafedra({
    required this.kafedraNomi,
    required this.rahbar,
    required this.kurslar,
  });

  void getDepartmentInfo() {
    print("Kafedra: $kafedraNomi");
    print("Rahbar: $rahbar");
    print("Kurslar: ${kurslar.join(', ')}");
  }
}

class Professor extends Kafedra {
  String ism;
  String ilmiyUnvon;

  Professor({
    required this.ism,
    required this.ilmiyUnvon,
    required super.kafedraNomi,
    required super.rahbar,
    required super.kurslar,
  });

  void teach() {
    print("$ism ($ilmiyUnvon) dars bermoqda.");
  }

  void research() {
    print("$ism ilmiy tadqiqot olib bormoqda.");
  }

  void publish() {
    print("$ism maqola nashr qildi.");
  }
}
