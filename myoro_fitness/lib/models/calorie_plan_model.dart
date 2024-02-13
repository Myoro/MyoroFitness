class CaloriePlanModel {
  final int tdee;
  final int caloriesPerDay;

  CaloriePlanModel({
    required this.tdee,
    required this.caloriesPerDay,
  });

  CaloriePlanModel.fromJSON(Map<String, Object?> json)
      : tdee = json['tdee'] as int,
        caloriesPerDay = json['calories_per_day'] as int;

  Map<String, Object?> get toJSON => {
        'tdee': tdee,
        'calories_per_day': caloriesPerDay,
      };
}
