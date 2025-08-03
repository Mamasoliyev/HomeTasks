import 'dart:io';

String IsmOl(String name){
  return (name == null || name == '') : name?.toUpperCase() ?? 'mehmon';
}
// List ListOl(List<String?>? ismlar ){

// }
void main() {
  print(IsmOl(stdin.readLineSync() ?? 'mehmon'));
}
