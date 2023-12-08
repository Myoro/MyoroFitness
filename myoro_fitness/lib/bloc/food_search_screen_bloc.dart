import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/models/food.dart";

abstract class FoodSearchScreenEvent {}
class FoodsLoadingEvent extends FoodSearchScreenEvent {}
class FoodsLoadedEvent extends FoodSearchScreenEvent {
  List<Food>? foods;
  FoodsLoadedEvent(this.foods);
}

class FoodSearchScreenState {
  final List<Food>? foods;
  FoodSearchScreenState({ this.foods });
}

class FoodSearchScreenBloc extends Bloc<FoodSearchScreenEvent, FoodSearchScreenState> {
  FoodSearchScreenBloc() : super(FoodSearchScreenState(foods: [])) {
    on<FoodsLoadingEvent>((event, emit) => emit(FoodSearchScreenState()));
    on<FoodsLoadedEvent>((event, emit) => emit(FoodSearchScreenState(foods: event.foods)));
  }
}