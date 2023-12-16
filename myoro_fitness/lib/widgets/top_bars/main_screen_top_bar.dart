import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/dark_mode_bloc.dart";
import "package:myoro_fitness/database.dart";

class MainScreenTopBar extends StatefulWidget implements PreferredSizeWidget {
  const MainScreenTopBar({ super.key });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<MainScreenTopBar> createState() => _MainScreenTopBarState();
}

class _MainScreenTopBarState extends State<MainScreenTopBar> {
  int streak = 0;

  @override
  void initState() {
    super.initState();
    Database().select("streak_entries").then((rows) {
      if(rows.isNotEmpty) setState(() => streak = rows.length);
    });
  }

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
              if(MediaQuery.of(context).size.width > 300) Text("Streak: $streak Days", style: theme.textTheme.titleMedium),
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