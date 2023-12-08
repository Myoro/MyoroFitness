import "package:flutter/material.dart";

class FoodInformationScreenTopBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodInformationScreenTopBar({ super.key });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Spacer(),
          InkWell(
            onTap: () => print("TODO"), // TODO
            child: Icon(Icons.check, size: 35, color: Theme.of(context).colorScheme.onPrimary)
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.pop(context), // TODO
            child: Icon(Icons.close, size: 35, color: Theme.of(context).colorScheme.onPrimary)
          )
        ]
      )
    );
  }
}