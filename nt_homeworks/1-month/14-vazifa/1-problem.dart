// ignore_for_file: public_member_api_docs, sort_constructors_first
class Inson {
  String ism;
  int yosh;
  String email;

  Inson(
    this.ism,
    this.yosh,
    this.email,
  );
  void getInfo() {
    print("$ism \n $yosh \n $email");
  }

  void study() {
    print("Talaba o'qiydimi? ");
  }
}

class Talaba extends Inson {
  String fan;
  bool kurs;

  Talaba(super.ism, super.yosh, super.email, this.fan, this.kurs);

  
  @override
  void study() {
    print("Talaba o'qiydimi ${kurs == true ? "ha": "yo\'q"}");
  }

  void takeExam() {
    print("Bugun $fan dan imtixon bo'ldi");
  }

}

void main(List<String> args) {
  Talaba talaba = Talaba('Nodirbek', 22, "n@gmail.com", "AI", true);
  talaba.getInfo();
  talaba.study();
  talaba.takeExam();
}
