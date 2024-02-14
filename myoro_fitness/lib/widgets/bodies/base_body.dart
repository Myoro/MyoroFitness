import 'package:flutter/material.dart';

/// [Widget] that all [Scaffold] bodies will use
///
/// Standard Padding --> ListView screen
class BaseBody extends StatelessWidget {
  /// Content within the [ListView]
  final List<Widget> children;

  const BaseBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: children,
        ),
      );
}
