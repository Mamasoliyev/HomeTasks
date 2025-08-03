// ignore_for_file: public_member_api_docs, sort_constructors_first
void main(List<String> args) {
  Sotuvchi sotuvchi = Sotuvchi("Nodirbke", "Mamasoliyev", "12345");
  print(sotuvchi.getFullName());
  print(sotuvchi.makeSale());

  Mijoz mijoz = Mijoz('Javohir', "Mamasoliyev", "214123", "553423");
  print(mijoz.makePurchase());
}

class Shaxs {
  String ism;
  String familiya;
  String sellerTelefon;

  Shaxs(
    this.ism,
    this.familiya,
    this.sellerTelefon,
  );

  String getFullName() {
    return "$ism $familiya";
  }
}

class Sotuvchi extends Shaxs {
  Sotuvchi(super.ism, super.familiya, super.sellerTelefon);
  String makeSale() {
    return "$sellerTelefon ga telefon qil";
  }
}

class Mijoz extends Shaxs {
  String mijoz_telefon;

  Mijoz(super.ism, super.familiya, super.sellerTelefon, this.mijoz_telefon);

  String makePurchase() {
    return "Mijoz bo'lmish $mijoz_telefon raqamli mijozga telefon qil";
  }
}
