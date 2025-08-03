import 'dart:io';

void main() {
  List<int> pupils = [13,12,0,51,36,21,35,14,23,1];

  stdout.write("Index kiriting: ");
  int index = int.parse(stdin.readLineSync()!);
  
  stdout.write("Flag holati(true/false): ");
  bool flag_checker = stdin.readLineSync() == 'true';

  if(index >= 0 && index < 10){
    if (flag_checker) {
      pupils[index] += 1;
    } else {
      if (pupils[index] > 0) {
        pupils[index] -= 1;
      } else {
        print("Bu sinfda o‘quvchi yo'q.");
      }
    }
  } else {
    print("Noto‘g‘ri index!");
  }
  print(pupils);
}
