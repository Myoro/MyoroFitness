import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/buttons/button_without_feedback.dart";

class FooterNavigationBar extends StatefulWidget {
  const FooterNavigationBar({super.key});

  @override
  State<FooterNavigationBar> createState() => _FooterNavigationBarState();
}

class _FooterNavigationBarState extends State<FooterNavigationBar> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool darkMode   = (theme.brightness == Brightness.dark) ? true : false;

    final List<Map<String, dynamic>> buttons = [
      {
        "primary":  "assets/img/Tracking${darkMode ? 'Dark' : 'Light'}.png",
        "selected": "assets/img/Tracking${darkMode ? 'Light' : 'Dark'}.png"
      },
      {
        "primary":  "assets/img/Calories${darkMode ? 'Dark' : 'Light'}.png",
        "selected": "assets/img/Calories${darkMode ? 'Light' : 'Dark'}.png"
      },
      {
        "primary":  "assets/img/Workouts${darkMode ? 'Dark' : 'Light'}.png",
        "selected": "assets/img/Workouts${darkMode ? 'Light' : 'Dark'}.png"
      }
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i = 0; i < buttons.length; i++)
          ButtonWithoutFeedback(
            onTap: () => setState(() { selected = i; }),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color:        (i == selected) ? theme.colorScheme.onPrimary : null,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    buttons[i][(i == selected) ? "selected" : "primary"],
                    width: MediaQuery.of(context).size.width / 3 - 40,
                    fit:   BoxFit.contain
                  ),
                ),
              ),
            )
          )
      ]
    );
  }
}