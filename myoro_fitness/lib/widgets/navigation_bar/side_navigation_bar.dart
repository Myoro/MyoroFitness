import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/buttons/button_without_feedback.dart";

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({ super.key });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme    = Theme.of(context);
    final String darkModeSrc = (theme.brightness == Brightness.dark) ? "Dark" : "Light";
    final List<Map<String, dynamic>> buttons = [
      { "src": "assets/img/Tracking$darkModeSrc.png", "onTap": () => {} },
      { "src": "assets/img/Calories$darkModeSrc.png", "onTap": () => {} },
      { "src": "assets/img/Workouts$darkModeSrc.png", "onTap": () => {} }
    ];

    return SizedBox(
      width: 72,
      child: ListView(
        children: [
          for(int i = 0; i < buttons.length; i++)
            ButtonWithoutFeedback(
              onTap: buttons[i]["onTap"],
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:   Image.asset(
                  buttons[i]["src"],
                  fit:   BoxFit.contain
                )
              )
            ),
        ]
      ),
    );
  }
}