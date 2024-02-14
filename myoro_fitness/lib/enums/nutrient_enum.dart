enum NutrientEnum {
  calories('Energy'),
  protein('Protein'),
  carbohydrates('Carbohydrates, by difference'),
  fats('Total lipid (fat)'),
  sugars('Total sugars'),
  fibers('Fiber, total dietary'),
  calcium('Calcium, Ca'),
  iron('Iron, Fe'),
  sodium('Sodium, Na'),
  vitaminA('Vitamin A, UI'),
  vitaminC('VitaminC, total ascorbic acid'),
  cholesterol('Cholesterol'),
  transFats('Fatty acids, total trans'),
  saturatedFats('Fatty acids, total saturated');

  final String apiNutrientName;

  const NutrientEnum(this.apiNutrientName);
}