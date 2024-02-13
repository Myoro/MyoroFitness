import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/dark_mode_cubit.dart';
import 'package:myoro_fitness/widgets/inputs/base_dropdown.dart';
import 'package:myoro_fitness/widgets/modals/calorie_plan_modal.dart';
import 'package:myoro_fitness/widgets/screens/home_screen.dart';

/// [AppBar] of [HomeScreen]
class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      title: Row(
        children: [
          Text('MyoroFitness', style: theme.textTheme.titleLarge),
          const Spacer(),
          BaseDropdown(
            icon: Icons.menu,
            items: [
              {
                'icon': Icons.sunny,
                'text': 'Enable ${theme.colorScheme.brightness == Brightness.dark ? 'Light' : 'Dark'} mode',
                'onTap': () => BlocProvider.of<DarkModeCubit>(context).toggle(),
              },
              {
                'icon': Icons.food_bank,
                'text': 'Your Calorie Plan',
                'onTap': () => CaloriePlanModal.show(context),
              },
            ],
            itemBuilder: (Map<String, dynamic> item) => PopupMenuItem(
              onTap: () => item['onTap'](),
              child: Wrap(
                spacing: 10,
                children: [
                  Icon(
                    item['icon'],
                    size: 30,
                    color: theme.colorScheme.onPrimary,
                  ),
                  Text(
                    item['text'],
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
