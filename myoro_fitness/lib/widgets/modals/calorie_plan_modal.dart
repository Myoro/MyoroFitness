import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/blocs/calorie_plan_cubit.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/formatters/calorie_input_formatter.dart';
import 'package:myoro_fitness/models/calorie_plan_model.dart';
import 'package:myoro_fitness/widgets/inputs/basic_text_field_form.dart';
import 'package:myoro_fitness/widgets/modals/base_modal.dart';

class CaloriePlanModal extends StatefulWidget {
  const CaloriePlanModal({super.key});

  static void show(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CaloriePlanModal(),
      );

  @override
  State<CaloriePlanModal> createState() => _CaloriePlanModalState();
}

class _CaloriePlanModalState extends State<CaloriePlanModal> {
  final TextEditingController _tdeeController = TextEditingController();
  final TextEditingController _caloriesPerDayController = TextEditingController();
  final ValueNotifier<String> _calorieDifference = ValueNotifier<String>('0');

  void setCaloriePlan() => BlocProvider.of<CaloriePlanCubit>(context).setCaloriePlan(
        CaloriePlanModel(
          tdee: int.parse(_tdeeController.text),
          caloriesPerDay: int.parse(_caloriesPerDayController.text),
        ),
      );

  void setCalorieDifference(String value, String controllerChanged) {
    if (controllerChanged == 'tdee') {
      _calorieDifference.value = '${int.parse(_caloriesPerDayController.text) - int.parse(value)}';
    } else if (controllerChanged == 'caloriesPerDay') {
      _calorieDifference.value = '${int.parse(value) - int.parse(_tdeeController.text)}';
    }
  }

  @override
  void dispose() {
    _caloriesPerDayController.dispose();
    _tdeeController.dispose();
    _calorieDifference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CaloriePlanCubit, CaloriePlanModel>(builder: (context, caloriePlan) {
        _caloriesPerDayController.text = caloriePlan.caloriesPerDay.toString();
        _tdeeController.text = caloriePlan.tdee.toString();

        return BaseModal(
          title: 'Your Calorie Plan',
          size: const Size(300, 215),
          showFooterButtons: true,
          yesText: 'Save',
          yesOnTap: () => setCaloriePlan(),
          content: Column(
            children: [
              BasicTextFieldForm(
                size: SizeEnum.medium,
                title: 'Calories Per Day',
                formatters: [CalorieInputFormatter()],
                onChanged: (value) => setCalorieDifference(value, 'caloriesPerDay'),
                controller: _caloriesPerDayController,
                textFieldWidth: 100,
              ),
              const SizedBox(height: 5),
              BasicTextFieldForm(
                size: SizeEnum.medium,
                title: 'TDEE',
                tooltip: 'Total Daily Energy Expenditure',
                formatters: [CalorieInputFormatter()],
                onChanged: (value) => setCalorieDifference(value, 'tdee'),
                controller: _tdeeController,
                textFieldWidth: 100,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Difference',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 100,
                    child: ValueListenableBuilder(
                      valueListenable: _calorieDifference,
                      builder: (context, calorieDifference, child) => Text(
                        calorieDifference,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
