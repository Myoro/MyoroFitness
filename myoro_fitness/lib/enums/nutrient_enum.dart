enum NutrientEnum {
  calories('Energy', 'Calories'),
  protein('Protein', 'Protein'),
  carbohydrates('Carbohydrate, by difference', 'Carbohydrates'),
  fats('Total lipid (fat)', 'Fat'),
  sugars('Total sugars', 'Sugar'),
  fibers('Fiber, total dietary', 'Fiber'),
  calcium('Calcium, Ca', 'Calcium'),
  iron('Iron, Fe', 'Iron'),
  sodium('Sodium, Na', 'Sodium'),
  vitaminA('Vitamin A, UI', 'Vitamin A'),
  vitaminC('Vitamin C, total ascorbic acid', 'Vitamin C'),
  cholesterol('Cholesterol', 'Cholesterol'),
  transFats('Fatty acids, total trans', 'Trans-Fats'),
  saturatedFats('Fatty acids, total saturated', 'Saturated Fats');

  final String apiNutrientName;
  final String title;

  const NutrientEnum(this.apiNutrientName, this.title);
}
