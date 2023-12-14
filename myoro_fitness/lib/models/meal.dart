import 'package:myoro_fitness/models/food.dart';

class Meal {
  final String name;
  final List<Food> foods;
  const Meal({ required this.name, this.foods = const [] });
} 