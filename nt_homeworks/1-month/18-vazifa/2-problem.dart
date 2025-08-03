Future<void> validatePhoneNumber(String telefonRaqam) async {
  if (telefonRaqam.length < 13) {
    return Future.error("Noto'g'ri telefon raqami");
  } else {
    return Future.value("Telefon raqami to'g'ri");
  }
}

void main() async {
  try {
    await validatePhoneNumber("+998901234567");
    print("Raqam to'g'ri");
  } catch (e) {
    print("Xatolik: $e");
  }
}
