import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_fitness/widgets/screens/food_information_screen.dart';

/// [AppBar] of [FoodInformationScreen]
class FoodInformationScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodInformationScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButtonWithoutFeedback(
              onTap: () => Navigator.pop(context),
              icon: Icons.home,
            ),
            const Spacer(),
            IconButtonWithoutFeedback(
              onTap: () {}, // TODO
              icon: Icons.check,
            ),
            IconButtonWithoutFeedback(
              onTap: () {}, // TODO
              icon: Icons.close,
            ),
          ],
        ),
      );
}
