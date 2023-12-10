import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/food_search_screen_bloc.dart";
import "package:myoro_fitness/widgets/top_bars/food_search_screen_top_bar.dart";
import "package:myoro_fitness/screens/food_information_screen.dart";

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

    return BlocProvider(
      create: (context) => FoodSearchScreenBloc(),
      child: BlocBuilder<FoodSearchScreenBloc, FoodSearchScreenState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const FoodSearchScreenTopBar(),
            body: (state.foods == null)
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
                    for(int i = 0; i < state.foods!.length; i++)
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FoodInformationScreen(food: state.foods![i]))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5, left: 17, right: 17),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:        theme.colorScheme.onPrimary
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.foods![i].name,
                                          style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                                          overflow: TextOverflow.ellipsis
                                        ),
                                        if(state.foods![i].company != null)
                                          Text(
                                            state.foods![i].company!,
                                            style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.primary),
                                            overflow: TextOverflow.ellipsis
                                          )
                                      ]
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    (state.foods![i].calories != null) ? "${state.foods![i].calories!.value}kcals" : "N/A",
                                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary)
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                      )
                  ]
                ),
              )
          );
        }
      ),
    );
  }
}