import "package:flutter/material.dart";
import "package:intl/intl.dart";
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

  void logDay() {
    if(calorieController.text.isEmpty || weightController.text.isEmpty) return;

    final String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    print(date);

    print(exercised);
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
    final List<Map<String, String>> data = [
      { "title": "Avg calories consumed daily", "value": "1234cal" },
      { "title": "Weight gained/lost", "value": "100lbs lost" },
      { "title": "Avg times exercised per week", "value": "2.4" }
    ];

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
                      BasicInput(controller: calorieController, centered: true),
                      const SizedBox(height: 4),
                      BasicInput(controller: weightController, centered: true),
                      const SizedBox(height: 18),
                      BasicDropdown(height: 28, centered: true, items: const [ "Yes", "No" ], onChanged: (value) => setState(() => exercised = (value == "yes") ? true : false)),
                      const SizedBox(height: 12)
                    ]
                  ),
                )
              ]
            ),
            const SizedBox(height: 10),
            TextHoverButton(
              title: "Log",
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