import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_fitness/database.dart';
import 'package:myoro_fitness/models/calorie_plan_model.dart';

class CaloriePlanCubit extends Cubit<CaloriePlanModel> {
  CaloriePlanCubit(super.caloriePlan);

  void setCaloriePlan(CaloriePlanModel caloriePlan) {
    Database.update('calorie_plan', caloriePlan.toJSON);
    emit(caloriePlan);
  }
}
