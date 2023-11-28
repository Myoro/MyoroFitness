import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/buttons/button_without_feedback.dart";

class FooterNavigationBar extends StatelessWidget {
  const FooterNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme    = Theme.of(context);
    final String darkModeSrc = (theme.brightness == Brightness.dark) ? "Dark" : "Light";
    final List<Map<String, dynamic>> buttons = [
      { "src": "assets/img/Tracking$darkModeSrc.png", "onTap": () => print("Hello") },
      { "src": "assets/img/Calories$darkModeSrc.png", "onTap": () => print("Calories") },
      { "src": "assets/img/Workouts$darkModeSrc.png", "onTap": () => print("Workouts") }
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i = 0; i < buttons.length; i++)
          ButtonWithoutFeedback(
            onTap: buttons[i]["onTap"],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child:   Image.asset(
                buttons[i]["src"],
                width: MediaQuery.of(context).size.width / 3 - 40,
                fit:   BoxFit.contain
              )
            )
          )
      ]
    );
  }
}