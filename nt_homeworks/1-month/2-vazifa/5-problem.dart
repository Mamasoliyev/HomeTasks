void main() {
  // Shape 1
  print("1)");
  for (int i = 1; i <= 5; i++) {
    print('*' * i);
  }

  // Shape 2
  print("\n2)");
  for (int i = 0; i < 5; i++) {
    print(' ' * i + '*' * (5 - i));
  }
}
