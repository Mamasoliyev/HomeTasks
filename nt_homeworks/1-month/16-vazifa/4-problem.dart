extension ParolValidator on String {
  bool isValidPassword() {
    final uzunlik = this.length >= 8;
    final kattaHarf = this.contains(RegExp(r'[A-Z]'));
    final maxsusBelgi = this.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

    return uzunlik && kattaHarf && maxsusBelgi;
  }
}

void main() {
  print("Strong@123".isValidPassword()); // true
  print("weakpass".isValidPassword()); // false
  print("Short1!".isValidPassword()); // false (uzunligi kam)
  print("NoSymbol123".isValidPassword()); // false (maxsus belgi yo'q)
}
