import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/dark_mode_bloc.dart";

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({ super.key });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DarkModeBloc, DarkModeState>(
      builder: (context, darkModeState) {
        final ThemeData theme = Theme.of(context);

        return AppBar(
          title: Row(
            children: [
              Image.asset(
                "assets/img/Logo${darkModeState.enabled ? "Dark" : "Light"}.png",
                width:  40,
                height: 40
              ),
              const Spacer(),
              if(MediaQuery.of(context).size.width > 300) Text("365 Days", style: theme.textTheme.titleMedium),
              const Spacer(),
              InkWell(
                onTap: () => BlocProvider.of<DarkModeBloc>(context).add(ToggleDarkModeEvent()),
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    "assets/img/Theme${darkModeState.enabled ? "Dark" : "Light"}.png",
                    width:  40,
                    height: 40
                  )
                )
              )
            ]
          )
        );
      }
    );
  }
}