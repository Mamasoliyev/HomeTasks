class SanoatMahsuloti {
  String nom;
  int yili;
  int narx;

  SanoatMahsuloti(this.nom, this.yili, this.narx);

  mahsulotlar() {
    return "Mahsulot: $nom, Nashr yili: $yili, Narx: $narx so'm.";
  }
}

void main() {
  SanoatMahsuloti product = SanoatMahsuloti("Telefon", 2019, 200000);
  print(product.mahsulotlar());

  SanoatMahsuloti product2 = SanoatMahsuloti("Laptop", 2020, 7000000);
  print(product2.mahsulotlar());
}