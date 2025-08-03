class Order {
  late final int orderId;

  void setOrderId(int id) {
    orderId = id;
  }

  void showOrder() {
    print('Buyurtma ID: $orderId');
  }
}

class Payment {
  late final double amountPaid;

  void setPayment(double amount) {
    amountPaid = amount;
  }

  void confirmPayment() {
    print('To‘lov muvaffaqiyatli amalga oshirildi: \$${amountPaid}');
  }
}

void main() {
  var order = Order();
  var payment = Payment();

  order.setOrderId(123);
  payment.setPayment(150.0);

  order.showOrder();
  payment.confirmPayment();
}
