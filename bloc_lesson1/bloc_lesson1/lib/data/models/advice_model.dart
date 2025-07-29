class AdviceModel {
  final int id;
  final String advice;

  AdviceModel({required this.id, required this.advice});

  factory AdviceModel.fromMap(Map<String, dynamic> json) {
    return AdviceModel(
      id: json['id'],
      advice: json['advice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advice': advice,
    };  
  }
}
