import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({ super.key });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextHoverButton(
            title: "Modify TDEE/Deficit",
            border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
            width: 250,
            onTap: () {} // TODO
          ),
          const SizedBox(height: 10),
          TextHoverButton(
            title: "Export your data to JSON",
            border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
            width: 250,
            onTap: () {} // TODO
          ),
          const SizedBox(height: 10),
          TextHoverButton(
            title: "Import your JSON data",
            border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
            width: 250,
            onTap: () {}
          )
        ]
      ),
    );
  }
}