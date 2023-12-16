import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/page_control_bloc.dart";
import "package:myoro_fitness/widgets/buttons/button_without_feedback.dart";

class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({ super.key });

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool darkMode   = (theme.brightness == Brightness.dark) ? true : false;

    final List<Map<String, dynamic>> buttons = [
      {
        "primary":  "assets/img/Tracking${darkMode ? 'Dark' : 'Light'}.png",
        "selected": "assets/img/Tracking${darkMode ? 'Light' : 'Dark'}.png",
        "onTap":    () => BlocProvider.of<PageControlBloc>(context).add(ChangePageEvent(PageControlEnum.tracking))
      },
      {
        "primary":  "assets/img/Calories${darkMode ? 'Dark' : 'Light'}.png",
        "selected": "assets/img/Calories${darkMode ? 'Light' : 'Dark'}.png",
        "onTap":    () => BlocProvider.of<PageControlBloc>(context).add(ChangePageEvent(PageControlEnum.calories))
      }
    ];

    return SizedBox(
      width: 72,
      child: ListView(
        children: [
          for(int i = 0; i < buttons.length; i++)
            ButtonWithoutFeedback(
              onTap: () { buttons[i]["onTap"](); setState(() { selected = i; }); },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color:        (i == selected) ? theme.colorScheme.onPrimary : null,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      buttons[i][(i == selected) ? "selected" : "primary"],
                      fit:   BoxFit.contain
                    ),
                  ),
                ),
              )
            ),
        ]
      ),
    );
  }
}