import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_event.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_state.dart';

class FoodSelectionBloc extends Bloc<FoodSelectionEvent, FoodSelectionState> {
  FoodSelectionBloc() : super(FoodSelectionState());
}