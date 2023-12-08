import "dart:convert";
import "package:myoro_fitness/models/food.dart";
import "package:http/http.dart";

class API {
  static Future<List<Food>> getFoods(String query) async {
    final Response response = await get(Uri.parse('https://api.nal.usda.gov/fdc/v1/foods/search?api_key=8gebCl8lwZ20aHXScHcsrCcPdqkKKP0xJF8DFgBr&query=$query'));

    if(response.statusCode != 200) return [];

    final List<Food> resultado = [];
    final List<dynamic> foods = jsonDecode(response.body)['foods'];
    for(int i = 0; i < foods.length; i++) { resultado.add(Food.fromJson(foods[i])); }

    return resultado;
  }
}