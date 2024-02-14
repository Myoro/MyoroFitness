class CaloriePlanModel {
  final int tdee;
  final int caloriesPerDay;

  CaloriePlanModel({
    required this.tdee,
    required this.caloriesPerDay,
  });

  CaloriePlanModel.fromJSON(Map<String, dynamic> json)
      : tdee = json['tdee'],
        caloriesPerDay = json['calories_per_day'];

  Map<String, Object?> get toJSON => {
        'tdee': tdee,
        'calories_per_day': caloriesPerDay,
      };
}
