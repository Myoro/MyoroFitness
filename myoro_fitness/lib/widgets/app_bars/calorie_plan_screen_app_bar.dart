import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
import 'package:myoro_fitness/widgets/screens/calorie_plan_screen.dart';

/// [AppBar] for [CaloriePlanScreen]
class CaloriePlanScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CaloriePlanScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _IconButton(
              onTap: () => Navigator.pop(context),
              icon: Icons.home,
            ),
            const Spacer(),
            _IconButton(
              onTap: () {}, // TODO
              icon: Icons.check,
            ),
            const SizedBox(width: 5),
            _IconButton(
              onTap: () {}, // TODO
              icon: Icons.close,
            ),
          ],
        ),
      );
}

class _IconButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;

  const _IconButton({required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) => ButtonWithoutFeedback(
        onTap: () => onTap(),
        child: Icon(
          icon,
          size: 40,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
}
