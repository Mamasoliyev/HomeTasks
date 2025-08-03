Function createMultiplier(int multiplier) {
  return (int number) {
    return number * multiplier;
  };
}

void main() {
  var multiplyBy2 = createMultiplier(2);
  print(multiplyBy2(5)); 

  var multiplyBy3 = createMultiplier(3);
  print(multiplyBy3(4));
}
