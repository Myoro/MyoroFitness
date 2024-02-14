import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_bloc.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_state.dart';
import 'package:myoro_fitness/widgets/bodies/base_body.dart';
import 'package:myoro_fitness/widgets/cards/food_card.dart';
import 'package:myoro_fitness/widgets/screens/food_selection_screen.dart';
import 'package:myoro_fitness/widgets/specifics/loading_bar.dart';

/// [Scaffold] body of [FoodSelectionScreen]
class FoodSelectionScreenBody extends StatelessWidget {
  const FoodSelectionScreenBody({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<FoodSelectionBloc, FoodSelectionState>(
    builder: (context, state) => BaseBody(
      children: state.foods != null
        ? List.generate(
          state.foods!.length,
          (index) => FoodCard(food: state.foods![index]),
        )
        : [
          SizedBox(height: MediaQuery.of(context).size.height / 2 - 60),
          const LoadingBar(),
        ],
    ),
  );
}