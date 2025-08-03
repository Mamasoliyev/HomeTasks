class Service {
  String title;
  double price;
  int? durationInDays;

  Service(this.title, this.price, this.durationInDays);

  String getServiceInfo() {
    String durationInfo = durationInDays != null
        ? "$durationInDays kun"
        : "Davomiylik belgilanmagan";

    return "Xizmat nomi: $title\nNarxi: \$${price.toStringAsFixed(2)}\nDavomiylik: $durationInfo";
  }
}
void main() {
  Service s1 = Service("Internet tozalash", 49.99, 30);
  print(s1.getServiceInfo());

  print("\n---\n");

  Service s2 = Service("Konsultatsiya", 25.00, null);
  print(s2.getServiceInfo());
}
