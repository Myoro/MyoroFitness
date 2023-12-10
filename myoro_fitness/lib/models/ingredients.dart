class Ingredients {
  late final List<String> ingredients;

  Ingredients(String? ingredients) {
    if(ingredients == null) {
      this.ingredients = [];
    } else {
      final List<String> split = ingredients!.split(',');
      this.ingredients = [];
      for(int i = 0; i < split.length; i++) { this.ingredients.add(split[i]); }
    }
  }
}