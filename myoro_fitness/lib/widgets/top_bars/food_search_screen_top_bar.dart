import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/dark_mode_bloc.dart";
import "package:myoro_fitness/widgets/basic_input.dart";

class FoodSearchScreenTopBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodSearchScreenTopBar({ super.key });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      title: Row(
        children: [
          const Spacer(),
          BasicInput(
            width:    MediaQuery.of(context).size.width - 200,
            height:   45,
            centered: true
          ),
          const Spacer(),
          InkWell(
            onTap: () => BlocProvider.of<DarkModeBloc>(context).add(ToggleDarkModeEvent()),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/img/Theme${(theme.brightness == Brightness.dark) ? "Dark" : "Light"}.png",
                width:  40,
                height: 40
              )
            )
          )
        ]
      )
    );
  }
}