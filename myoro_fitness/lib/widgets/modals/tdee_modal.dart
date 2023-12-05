import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/tdee_bloc.dart";
import "package:myoro_fitness/widgets/modals/basic_modal.dart";
import "package:myoro_fitness/widgets/basic_input.dart";
import "package:myoro_fitness/widgets/basic_dropdown.dart";

class TDEEModal extends StatefulWidget {
  const TDEEModal({ super.key });

  @override
  State<TDEEModal> createState() => _TDEEModalState();
}

class _TDEEModalState extends State<TDEEModal> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BasicModal(
      title: "Calorie Plan",
      content: Text(
        "Would you like to set a calorie plan?",
        style: theme.textTheme.titleMedium
      ),
      onYes: () {
        Navigator.pop(context);

        List<Map<String, dynamic>> data = [
          { "title": "Age", "type": "input" },
          { "title": "Gender", "type": "dropdown", "options": [ "Man", "Woman" ] },
          { "title": "Weight (kg)", "type": "input" },
          {
            "title": "Height", "type": "dropdown",
            "options": List.generate(75, (index) {
              final int centimeter       = 125 + index + 4;
              final String feet          = (centimeter / 30.48).toStringAsFixed(2);
              final String feetRemainder = (double.parse("0.${feet[2]}${feet[3]}") * 12).round().toString();
              
              return "${centimeter}cm - ${feet[0]}'${feetRemainder}ft";
            })
          },
          {
            "title": "Activity Level", "type": "dropdown",
            "options": [
              "Sedentary",         // 1.2
              "Lightly active",    // 1.375
              "Moderately active", // 1.55
              "Very active"        // 1.725
            ]
          }
        ];

        showDialog(
          context: context,
          builder: (context) => BasicModal(
            title: "Getting your TDEE",
            onYes: () => print("Fuck Flutter fuck verbosity"),
            content: Column(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for(int i = 0; i < data.length; i++) ...[
                          SizedBox(
                            height: 40,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "${data[i]['title']}:",
                                style: theme.textTheme.bodyMedium)
                              )
                          ),
                          const SizedBox(height: 10),
                        ],
                        const SizedBox(height: 15),
                        Text("TDEE:", style: theme.textTheme.labelMedium),
                      ]
                    ),
                    const SizedBox(width: 10),
                    SizedBox( // Remove this
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for(int i = 0; i < data.length; i++) ...[
                            (data[i]["type"] == "input")
                              ? BasicInput(
                                onChanged: (value) {
                                  int sender = (value.length == 0) ? 0 : int.parse(value);

                                  switch(data[i]["title"]) {
                                    case "Age":
                                      BlocProvider.of<TDEEBloc>(context).add(GetTDEEAgeEvent(sender));
                                      break;
                                    case "Weight (kg)":
                                      BlocProvider.of<TDEEBloc>(context).add(GetTDEEWeightEvent(sender));
                                      break;
                                  }
                                },
                                textType: BasicInputEnum.digitsOnly
                              )
                              : Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: BasicDropdown(
                                  items: data[i]["options"],
                                  height: 25,
                                  onChanged: (value) {
                                    switch(data[i]["title"]) {
                                      case "Gender":
                                        BlocProvider.of<TDEEBloc>(context).add(GetTDEEAgeEvent(value));
                                        break;
                                      case "Height":
                                        BlocProvider.of<TDEEBloc>(context).add(GetTDEEHeightEvent(int.parse(value.substring(0, 3))));
                                        break;
                                      case "Activity Level":
                                        switch(value) {
                                          case "Sedentary":
                                            BlocProvider.of<TDEEBloc>(context).add(GetTDEELifestyleEvent(1.2));
                                            break;
                                          case "Lightly active":
                                            BlocProvider.of<TDEEBloc>(context).add(GetTDEELifestyleEvent(1.375));
                                            break;
                                          case "Moderately active":
                                            BlocProvider.of<TDEEBloc>(context).add(GetTDEELifestyleEvent(1.55));
                                            break;
                                          case "Very active":
                                            BlocProvider.of<TDEEBloc>(context).add(GetTDEELifestyleEvent(1.725));
                                            break;
                                        }

                                        break;
                                    }
                                  }
                                ),
                              ),
                            const SizedBox(height: 10),
                          ],
                          const SizedBox(height: 15),
                          BlocBuilder<TDEEBloc, TDEEState>(
                            builder: (context, state) {
                              String tdee = "Not Complete";
                              if(state.tdeeIsCalculable()) tdee = state.calculateTDEE().toString();
                              return Text(tdee, style: theme.textTheme.bodyMedium);
                            }
                          ),
                        ]
                      ),
                    ),
                  ]
                ),
              ],
            )
          )
        );
      }
    );
  }
}