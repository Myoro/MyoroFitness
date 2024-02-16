// ignore_for_file: curly_braces_in_flow_control_structures

import "dart:convert";
import "dart:io";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";
import "package:myoro_fitness/widgets/modals/tdee_modal.dart";
import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({ super.key });

  void downloadJSON() async {
    // final String data = jsonEncode({
    final String data = const JsonEncoder.withIndent('  ').convert({
      "dark_mode":      await Database().select("dark_mode"),
      "calorie_plan":   await Database().select("calorie_plan"),
      "added_foods":    await Database().select("added_foods"),
      "meals":          await Database().select("meals"),
      "streak_entries": await Database().select("streak_entries"),
    });
    final Directory temporaryDirectory = await getTemporaryDirectory();
    final String path = '${temporaryDirectory.path}/MyoroFitnessData.json';
    File file = File(path);
    await file.writeAsString(data);
    OpenFile.open(path);
  }

  void importJSON() async {
    String? path = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['json'],
    ).then((result) => result?.files.single.path);

    if(path == null)
      return;
    else if(!path.contains("MyoroFitnessData.json"))
      return;

    final Map<String, dynamic> data = jsonDecode(File(path).readAsStringSync());

    await Database().resetDatabase();
    await Database().init;
    await Database().update("dark_mode", "enabled", data["dark_mode"][0]["enabled"]);
    for(int i = 0; i < data["calorie_plan"][0].length; i++)
      await Database().update("calorie_plan", data["calorie_plan"][0].keys.elementAt(i), data["calorie_plan"][0].values.elementAt(i));
    for(int i = 0; i < data["added_foods"].length; i++)
      await Database().insert("added_foods", { "food": data["added_foods"][i]["food"] });
    for(int i = 0; i < data["meals"].length; i++)
      await Database().update("meals", "foods", data["meals"][i]["foods"], { "meal_name": data["meals"][i]["meal_name"] });
    for(int i = 0; i < data["streak_entries"].length; i++) {
      await Database().insert(
        "streak_entries",
        {
          "calories":  data["streak_entries"][i]["calories"],
          "weight":    data["streak_entries"][i]["weight"],
          "exercised": data["streak_entries"][i]["exercised"],
          "date":      data["streak_entries"][i]["date"]
        }
      );
    }
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
            )
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
            onTap: () => importJSON()
          )
        ]
      ),
    );
  }
}