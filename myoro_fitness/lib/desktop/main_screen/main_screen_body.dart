import 'package:flutter/material.dart';
import 'package:myoro_fitness/shared/widgets/bodies/base_body.dart';

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key});

  @override
  Widget build(BuildContext context) => const BaseBody(
        child: Text(
          'Start',
          style: TextStyle(
            color: Colors.pink,
          ),
        ),
      );
}
