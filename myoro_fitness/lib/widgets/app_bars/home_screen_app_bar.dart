import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/dark_mode_cubit.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
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
          ButtonWithoutFeedback(
            onTap: () => BlocProvider.of<DarkModeCubit>(context).toggle(),
            child: Icon(
              Icons.sunny,
              size: 40,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
