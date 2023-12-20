import "package:flutter/material.dart";
import "package:myoro_fitness/bloc/page_control_bloc.dart";
import "package:myoro_fitness/constants/navigation_bar_buttons.dart";
import "package:myoro_fitness/widgets/buttons/navigation_bar_button.dart";

class FooterNavigationBar extends StatelessWidget {
  final PageControlEnum selected;

  const FooterNavigationBar({
    super.key,
    required this.selected
  });

  @override
  Widget build(BuildContext context) {
    final NavigationBarButtons buttons = NavigationBarButtons(context: context, size: 50);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(final Map<String, dynamic> button in buttons.buttons)
          NavigationBarButton(
            onTap: button["onTap"],
            child: selected != button["value"] ? button["primary"] : button["selected"],
            selected: selected == button["value"]
          )
      ]
    );
  }
}