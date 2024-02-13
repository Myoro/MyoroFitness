import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/app_bars/home_screen_app_bar.dart';

/// Menu used for fixed UI dropdown option selects, like in [HomeScreenAppBar]
class BaseDropdown<T> extends StatelessWidget {
  /// [BaseDropdown]'s icon that will always be displaying
  final IconData icon;

  /// [BaseDropdown] content
  final List<T> items;

  /// [BaseDropdown] function that returns the dropdown widgets
  final PopupMenuItem Function(T) itemBuilder;

  /// [BaseDropdown] tooltip if nessecary
  final String? tooltip;

  const BaseDropdown({
    super.key,
    required this.icon,
    required this.items,
    required this.itemBuilder,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;

    return PopupMenuButton(
      tooltip: '',
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      itemBuilder: (BuildContext context) => items.map((item) => itemBuilder(item)).toList(),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2,
          color: onPrimary,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      offset: const Offset(20, 50),
      child: Icon(
        icon,
        size: 40,
        color: onPrimary,
      ),
    );
  }
}
