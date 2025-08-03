extension HaftaKuni on DateTime {
  String haftaKuni() {
    switch (this.weekday) {
      case 1:
        return "Dushanba";
        break;
        case 2:
        return "Seshanba";
        break;
        case 3:
        return "Chorshanba";
        break;
        case 4:
        return "Payshanba";
        break;
        case 5:
        return "Juma";
        break;
        case 6:
        return "Shanba";
        break;
        case 7:
        return "Yakshanba";
        break;
      default:
      return "Xato kun";
    }
  }
}

void main(List<String> args) {
  print(DateTime(2024, 11, 18).haftaKuni());
}
