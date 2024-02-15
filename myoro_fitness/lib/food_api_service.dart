// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:http/http.dart';
import 'package:myoro_fitness/models/food_model.dart';

class FoodAPIService {
  static Future<List<FoodModel>> searchFoods(String query) async {
    final Response response = await get(
      Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=8gebCl8lwZ20aHXScHcsrCcPdqkKKP0xJF8DFgBr&query=$query',
      ),
    );

    if (response.statusCode != 200) return [];

    final List<FoodModel> foods = [];
    // for (final Map<String, dynamic> json in jsonDecode(response.body)['foods']) foods.add(FoodModel.fromJSON(json));
    for (final Map<String, dynamic> json in jsonDecode(response.body)['foods']) {
      print(json['servingSizeUnit']);
      foods.add(FoodModel.fromJSON(json));
    }

    return foods;
  }
}
