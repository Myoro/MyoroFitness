import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/widgets/basic_dropdown.dart";
import "package:myoro_fitness/widgets/basic_input.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";

class TrackingPage extends StatefulWidget {
  const TrackingPage({ super.key });

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final TextEditingController calorieController  = TextEditingController();
  final TextEditingController weightController   = TextEditingController();
  bool exercised = true;
  final List<Map<String, String>> data = [
    { "title": "Avg calories consumed daily", "value": "0cal" },
    { "title": "Weight gained/lost", "value": "0lbs lost" },
    { "title": "Avg times exercised per week", "value": "0" }
  ];


  void logDay() async {
    if(calorieController.text.isEmpty || weightController.text.isEmpty) return;

    final String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final Map<String, Object?> row = await Database().get("streak_entries", { "date": date });

    if(row.isEmpty) {
      Database().insert("streak_entries", {
        "calories":  int.parse(calorieController.text),
        "weight":    int.parse(weightController.text),
        "exercised": exercised ? 1 : 0,
        "date":      date
      });
    } else {
      final Map<String, String> condition = { "date": date };
      await Database().update("streak_entries", "calories", int.parse(calorieController.text), condition);
      await Database().update("streak_entries", "weight", int.parse(weightController.text), condition);
      await Database().update("streak_entries", "exercised", exercised ? 1 : 0, condition);
    }
  }

  @override
  void initState() {
    super.initState();
    Database().select("streak_entries").then((rows) {
      if(rows.isEmpty) return;

      int avgCalories = 0;
      int timesExercised = 0;
      int weightLost = (rows[0]["weight"] as int) - (rows[rows.length - 1]["weight"] as int);
      for(final row in rows) {
        avgCalories += row["calories"] as int;
        timesExercised += row["exercised"] as int;
      }
      avgCalories = avgCalories ~/ rows.length;
      timesExercised += timesExercised ~/ 7;

      setState(() {
        data[0]["value"] = "${avgCalories}cal";
        data[1]["value"] = "${weightLost}lbs ${(weightLost >= 0) ? 'lost' : 'gained'}";
        data[2]["value"] = timesExercised.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    calorieController.dispose();
    weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            for(final Map<String, String> item in data) ...[
              Wrap(
                clipBehavior: Clip.hardEdge,
                alignment: WrapAlignment.center,
                children: [
                  Text("${item['title']}: ", style: theme.textTheme.labelMedium),
                  Text("${item['value']}", style: theme.textTheme.bodyMedium)
                ]
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 20),
            Text("Log your streak", style: theme.textTheme.labelLarge, textAlign: TextAlign.center),
            Row(
              children: [
                SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      Text("Calories:", style: theme.textTheme.labelLarge),
                      const SizedBox(height: 10),
                      Text("Weight:", style: theme.textTheme.labelLarge),
                      const SizedBox(height: 10),
                      Text("Exercised?:", style: theme.textTheme.labelLarge)
                    ]
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      BasicInput(
                        controller: calorieController,
                        centered: true,
                        textType: BasicInputEnum.digitsOnly
                      ),
                      const SizedBox(height: 4),
                      BasicInput(
                        controller: weightController,
                        centered: true,
                        textType: BasicInputEnum.digitsOnly
                      ),
                      const SizedBox(height: 18),
                      BasicDropdown(
                        height: 28,
                        centered: true,
                        items: const [ "Yes", "No" ],
                        onChanged: (value) => setState(() => exercised = (value == "yes") ? true : false)
                      ),
                      const SizedBox(height: 12)
                    ]
                  ),
                )
              ]
            ),
            const SizedBox(height: 10),
            TextHoverButton(
              title: "Log  ${DateFormat('dd-MM-yyyy').format(DateTime.now())}",
              onTap: () => logDay(), // TODO
              border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
              width: double.infinity
            )
          ]
        )
      )
    );
  }
}