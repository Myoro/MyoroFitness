import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/bloc/page_control_bloc.dart';

class NavigationBarButtons {
  final BuildContext context;
  final double size;
  late final ThemeData theme;
  late final List<Map<String, dynamic>> buttons;

  NavigationBarButtons({ required this.context, required this.size }) {
    theme = Theme.of(context);
    buttons = [];
    buttons.add({
      "primary": Icon(Icons.track_changes, color: theme.colorScheme.onPrimary, size: size),
      "selected": Icon(Icons.track_changes, color: theme.colorScheme.primary, size: size),
      "onTap": () => BlocProvider.of<PageControlBloc>(context).add(ChangePageEvent(PageControlEnum.tracking)),
      "value": PageControlEnum.tracking
    });
    buttons.add({
      "primary": Icon(Icons.food_bank, color: theme.colorScheme.onPrimary, size: size),
      "selected": Icon(Icons.food_bank, color: theme.colorScheme.primary, size: size),
      "onTap": () => BlocProvider.of<PageControlBloc>(context).add(ChangePageEvent(PageControlEnum.calories)),
      "value": PageControlEnum.calories
    });
    buttons.add({
      "primary":  Icon(Icons.settings, color: theme.colorScheme.onPrimary, size: size),
      "selected": Icon(Icons.settings, color: theme.colorScheme.primary, size: size),
      "onTap": () => BlocProvider.of<PageControlBloc>(context).add(ChangePageEvent(PageControlEnum.settings)),
      "value": PageControlEnum.settings
    });
  }
}