import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/food_search_screen_bloc.dart";
import "package:myoro_fitness/api.dart";
import "package:myoro_fitness/widgets/basic_input.dart";
import "package:myoro_fitness/screens/custom_food_screen.dart";

class FoodSearchScreenTopBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodSearchScreenTopBar({ super.key });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final FoodSearchScreenBloc bloc = BlocProvider.of<FoodSearchScreenBloc>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          InkWell(
            onTap: () => print("Add meal"),
            customBorder: const CircleBorder(),
            child: Icon(Icons.check, color: theme.colorScheme.onPrimary, size: 40)
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            customBorder: const CircleBorder(),
            child: Icon(Icons.close, color: theme.colorScheme.onPrimary, size: 40)
          ),
          const Spacer(),
          BasicInput(
            width:    MediaQuery.of(context).size.width - 250,
            height:   45,
            centered: true,
            placeholder: "Search for Foods",
            onChanged: (value) async {
              if(value.length > 0) {
                BlocProvider.of<FoodSearchScreenBloc>(context).add(FoodsLoadingEvent());
                BlocProvider.of<FoodSearchScreenBloc>(context).add(FoodsLoadedEvent(await API.getFoods(value)));
              } else {
                BlocProvider.of<FoodSearchScreenBloc>(context).add(FoodsLoadedEvent([]));
              }
            }
          ),
          const Spacer(),
          InkWell(
            onTap: () => print("QR Code Lookup"), // TODO
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Image.asset(
                "assets/img/Barcode${(theme.brightness == Brightness.dark) ? 'Dark' : 'Light'}.png",
                width: 40,
                height: 40
              ),
            )
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomFoodScreen(bloc: bloc)
              )
            ),
            customBorder: const CircleBorder(),
            child: Icon(Icons.add, color: theme.colorScheme.onPrimary, size: 40)
          )
        ]
      )
    );
  }
}