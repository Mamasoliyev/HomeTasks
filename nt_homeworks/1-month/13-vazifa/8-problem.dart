void main(List<String> args) {
  var jufts = [1, 2, 3, 4, 5, 6];
  if (jufts[0].isOdd) {
    jufts.removeAt(0);
  }
  print(jufts.skipWhile(
    (value) => value.isEven,
  ));
}
