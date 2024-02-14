import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_bloc.dart';
import 'package:myoro_fitness/blocs/food_selection_bloc/food_selection_event.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
import 'package:myoro_fitness/widgets/inputs/food_selection_screen_search_bar.dart';
import 'package:myoro_fitness/widgets/screens/food_selection_screen.dart';

/// [AppBar] of [FoodSelectionScreen]
class FoodSelectionScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FoodSelectionScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<FoodSelectionScreenAppBar> createState() => _FoodSelectionScreenAppBarState();
}

class _FoodSelectionScreenAppBarState extends State<FoodSelectionScreenAppBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          ButtonWithoutFeedback(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.home,
              size: 40,
              color: onPrimary,
            ),
          ),
          const Spacer(),
          FoodSelectionScreenSearchBar(
            onChanged: (query) async => BlocProvider.of<FoodSelectionBloc>(context).add(SetFoodsEvent(query)),
          ),
          const Spacer(),
          ButtonWithoutFeedback(
            onTap: () {}, // TODO
            tooltip: 'Add Food Manually',
            child: Icon(
              Icons.add,
              size: 40,
              color: onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
