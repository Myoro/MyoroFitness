import 'package:flutter/material.dart';
import 'package:myoro_fitness/main.dart';
import 'package:myoro_fitness/widgets/app_bars/home_screen_app_bar.dart';
import 'package:myoro_fitness/widgets/bodies/home_screen_body.dart';

/// Main screen of the application
///
/// Used in [App]
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: HomeScreenAppBar(),
        body: HomeScreenBody(),
      );
}
