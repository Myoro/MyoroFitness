import "dart:convert";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/models/ingredients.dart";
import "package:myoro_fitness/models/nutrient.dart";

abstract class FoodSearchScreenEvent {}
class FoodsLoadingEvent extends FoodSearchScreenEvent {}
class GetAddedFoodsFromDatabase extends FoodSearchScreenEvent {}
class FoodsLoadedEvent extends FoodSearchScreenEvent {
  final List<Food>? foods;
  FoodsLoadedEvent(this.foods);
}
class FoodAddedEvent extends FoodSearchScreenEvent {
  final Food food;
  FoodAddedEvent(this.food);
}

class FoodSearchScreenState {
  final bool loading;
  final List<Food> foods;
  final List<Food> addedFoods;

  FoodSearchScreenState({ this.foods = const [], this.addedFoods = const [], this.loading = false });

  FoodSearchScreenState copyWith({
    bool? loading,
    List<Food>? foods,
    List<Food>? addedFoods
  }) => FoodSearchScreenState(
    loading: loading ?? this.loading,
    foods: foods ?? this.foods,
    addedFoods: addedFoods ?? this.addedFoods
  );
}

class FoodSearchScreenBloc extends Bloc<FoodSearchScreenEvent, FoodSearchScreenState> {
  FoodSearchScreenBloc() : super(FoodSearchScreenState()) {
    on<FoodsLoadingEvent>((event, emit) => emit(state.copyWith(loading: true)));
    on<FoodsLoadedEvent>((event, emit) => emit(state.copyWith(loading: false, foods: event.foods)));
    on<FoodAddedEvent>((event, emit) {
      Database().insertAddedFood(jsonEncode(event.food.toJson()));
      emit(state.copyWith(addedFoods: [ ...state.addedFoods, event.food ]));
    });
    on<GetAddedFoodsFromDatabase>((event, emit) async {
      final List<Map<String, Object?>> rows = await Database().select("added_foods");
      final List<Food> result = [];
      for(final Map<String, Object?> row in rows) {
        final Map<String, dynamic> rowJson = jsonDecode(row["food"] as String);
        result.add(Food(
          name:          rowJson["name"],
          company:       rowJson["company"],
          calories:      (rowJson["calories"] != null) ? Nutrient(value: rowJson["calories"]["value"], unit: Unit.kcal) : null,
          protein:       (rowJson["protein"] != null) ? Nutrient(value: rowJson["protein"]["value"], unit: Nutrient.getUnit(rowJson["protein"]["unit"])) : null,
          fat:           (rowJson["fat"] != null) ? Nutrient(value: rowJson["fat"]["value"], unit: Nutrient.getUnit(rowJson["fat"]["unit"])) : null,
          carbohydrates: (rowJson["carbohydrates"] != null) ? Nutrient(value: rowJson["carbohydrates"]["value"], unit: Nutrient.getUnit(rowJson["carbohydrates"]["unit"])) : null,
          ingredients:   (rowJson["ingredients"] != null) ? Ingredients(rowJson["ingredients"]) : null
        ));
      }
      emit(state.copyWith(addedFoods: result));
    });
  }
}