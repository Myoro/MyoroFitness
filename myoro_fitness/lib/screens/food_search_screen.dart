import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/food_search_screen_bloc.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/widgets/buttons/food_button.dart";
import "package:myoro_fitness/widgets/top_bars/food_search_screen_top_bar.dart";

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({ super.key });

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation  = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<FoodSearchScreenBloc, FoodSearchScreenState>(
      builder: (context, state) {
        final FoodSearchScreenBloc bloc = BlocProvider.of<FoodSearchScreenBloc>(context);
    
        bloc.add(GetAddedFoodsFromDatabase());
    
        return Scaffold(
          appBar: FoodSearchScreenTopBar(foodSearchScreenBlocState: state),
          body: (state.loading)
            ?
            SizedBox(
              height: double.infinity,
              child: Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => Text(
                    ".${'.' * (2 * _animation.value).round()}",
                    style: theme.textTheme.titleLarge
                  )
                ),
              ),
            )
            :
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ListView(
                children: [
                  if(state.addedFoods.isNotEmpty && state.foods.isEmpty) ...[
                    Text("Previously Added Foods", style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
                    for(final Food food in state.addedFoods)
                      FoodButton(food: food),
                    const SizedBox(height: 40),
                  ],
                  for(final Food food in state.foods)
                    FoodButton(food: food),
                ]
              ),
            )
        );
      }
    );
  }
}