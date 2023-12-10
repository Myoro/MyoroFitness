import "package:flutter/material.dart";

class CustomFoodScreenTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomFoodScreenTopBar({ super.key });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Spacer(),
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
        ]
      )
    );
  }
}