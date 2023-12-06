import "package:flutter/material.dart";
import "package:myoro_fitness/api.dart";
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
            centered: true,
            placeholder: "Search for Foods",
            onChanged: (value) => API.getFoods()
          ),
          const Spacer(),
          InkWell(
            onTap: () => print("Add custom food"), // TODO
            customBorder: const CircleBorder(),
            child: Icon(Icons.add, color: theme.colorScheme.onPrimary, size: 50)
          )
        ]
      )
    );
  }
}