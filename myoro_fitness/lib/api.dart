// ignore_for_file: curly_braces_in_flow_control_structures

import "dart:convert";
import "package:myoro_fitness/models/food.dart";
import "package:http/http.dart";

class API {
  static Future<List<Food>> getFoods(String query) async {
    final Response response = await get(Uri.parse('https://api.nal.usda.gov/fdc/v1/foods/search?api_key=8gebCl8lwZ20aHXScHcsrCcPdqkKKP0xJF8DFgBr&query=$query'));

    if(response.statusCode != 200) return [];

    final List<Food> result = [];
    final List<dynamic> foods = jsonDecode(response.body)['foods'];
    for(final Map<String, dynamic> food in foods) { // Sometimes the query is mistakenly in grams
      final Map<String, dynamic> formattedFood = {};

      formattedFood["name"] = food["description"];
      formattedFood["ingredients"] = food["ingredients"];
      if(food["brandName"] != null) formattedFood["company"] = food["brandName"];
      for(final Map<String, dynamic> nutrientInformation in food["foodNutrients"]) {
        switch(nutrientInformation["nutrientName"]) {
          case "Energy":
            formattedFood["calories"] = {
              "nutrientNumber": nutrientInformation["nutrientNumber"],
              "unitName": nutrientInformation["unitName"]
            };
            break;
          case "Protein":
            formattedFood["protein"] = {
              "nutrientNumber": nutrientInformation["nutrientNumber"],
              "unitName": nutrientInformation["unitName"]
            };
            break;
          case "Fatty acids, total saturated":
            formattedFood["fat"] = {
              "nutrientNumber": nutrientInformation["nutrientNumber"],
              "unitName": nutrientInformation["unitName"]
            };
            break;
          case "Carbohydrate, by difference":
            formattedFood["carbohydrates"] = {
              "nutrientNumber": nutrientInformation["nutrientNumber"],
              "unitName": nutrientInformation["unitName"]
            };
        }
      }

      result.add(Food.fromJson(formattedFood));
    }

    return result;
  }
}