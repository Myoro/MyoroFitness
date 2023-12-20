import "dart:convert";
import "dart:io";
import "package:flutter/material.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";
import "package:myoro_fitness/widgets/modals/tdee_modal.dart";
import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({ super.key });

  void downloadJSON() async {
    final List<Map<String, Object?>> caloriePlan = await Database().select("calorie_plan");
    final List<Map<String, Object?>> addedFoods = await Database().select("added_foods");
    final List<Map<String, Object?>> meals = await Database().select("meals");
    final List<Map<String, Object?>> streakEntries = await Database().select("streak_entries");

    // final String data = jsonEncode({
    final String data = const JsonEncoder.withIndent('  ').convert({
      "caloriePlan": caloriePlan,
      "addedFoods": addedFoods,
      "meals": meals,
      "streakEntries": streakEntries
    });
    final Directory temporaryDirectory = await getTemporaryDirectory();
    final String path = '${temporaryDirectory.path}/MyoroFitnessData.json';
    File file = File(path);
    await file.writeAsString(data);
    OpenFile.open(path);
  }

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
            onTap: () => showDialog(
              context: context,
              builder: (context) => const TDEEModal(mainDescription: "Would you like to alter your calorie plan?")
            ) // TODO
          ),
          const SizedBox(height: 10),
          TextHoverButton(
            title: "Export your data to JSON",
            border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
            width: 250,
            onTap: () => downloadJSON() // TODO
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