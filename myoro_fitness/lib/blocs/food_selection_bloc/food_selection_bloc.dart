import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_event.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_state.dart';
import 'package:myoro_fitness/food_api_service.dart';

class FoodSelectionBloc extends Bloc<FoodSelectionEvent, FoodSelectionState> {
  FoodSelectionBloc() : super(FoodSelectionState()) {
    on<SetFoodsEvent>((event, emit) async {
      emit(state.copyWith(foods: null));
      emit(state.copyWith(foods: await FoodAPIService.searchFoods(event.query)));
    });
  }
}