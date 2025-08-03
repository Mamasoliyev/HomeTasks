class ElektrAvtomobil {
  String model;
  int batareyaSigimi;
  int masofa;

  ElektrAvtomobil(this.model, this.batareyaSigimi, this.masofa);

  ElektrAvtomobil.tezQuvvatOluvchi(this.model)
      : batareyaSigimi = 60,
        masofa = 60 * 5;

  int masofaniHisobla() {
    return batareyaSigimi * 5;
  }

  void avtomobilMalumotlari() {
    print('Model: $model');
    print('Batareya sig\'imi: ${batareyaSigimi} kVt-soat');
    print('Yuradigan masofa: ${masofaniHisobla()} km');
  }
}

void main() {
  var avto1 = ElektrAvtomobil("Tesla", 60, 300);
  avto1.avtomobilMalumotlari();

  var avto2 = ElektrAvtomobil.tezQuvvatOluvchi("Nissan Leaf");
  avto2.avtomobilMalumotlari();
}