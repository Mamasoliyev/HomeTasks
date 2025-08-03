void main() {
  double add(double x, double y) => x + y;
  double subtract(double x, double y) => x - y;
  double multiply(double x, double y) => x * y;
  double divide(double x, double y) => x / y;

  print(applyOperation(4, 6, add)); 
  print(applyOperation(4, 6, subtract)); 
  print(applyOperation(4, 6, multiply)); 
}
double applyOperation(
    double a, double b, double Function(double, double) operation) {
  return operation(a, b);
}