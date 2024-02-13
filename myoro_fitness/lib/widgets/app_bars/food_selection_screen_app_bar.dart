import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
import 'package:myoro_fitness/widgets/screens/food_selection_screen.dart';

/// [AppBar] of [FoodSelectionScreen]
class FoodSelectionScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodSelectionScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ButtonWithoutFeedback(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.home,
                size: 40,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      );
}
