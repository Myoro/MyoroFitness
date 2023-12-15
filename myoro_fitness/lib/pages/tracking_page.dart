import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/basic_input.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";

class TrackingPage extends StatelessWidget {
  const TrackingPage({ super.key });

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
        child: Column(
          children: [
            for(final Map<String, String> item in data) ...[
              Wrap(
                clipBehavior: Clip.hardEdge,
                children: [
                  Text("${item['title']}: ", style: theme.textTheme.labelMedium),
                  Text("${item['value']}", style: theme.textTheme.bodyMedium)
                ]
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 20),
            Text("Log your streak", style: theme.textTheme.labelLarge),
            Row(
              children: [
                SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 7),
                      Text("Calories:", style: theme.textTheme.labelLarge),
                      const SizedBox(height: 7),
                      Text("Weight:", style: theme.textTheme.labelLarge),
                      const SizedBox(height: 7),
                      Text("Exercised?:", style: theme.textTheme.labelLarge)
                    ]
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    children: [
                      BasicInput(centered: true, height: 30),
                      BasicInput(centered: true, height: 30),
                      BasicInput(centered: true, height: 30)
                    ]
                  ),
                )
              ]
            ),
            const SizedBox(height: 10),
            TextHoverButton(
              title: "Log",
              onTap: () {},
              border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
              width: double.infinity
            )
          ]
        )
      )
    );
  }
}