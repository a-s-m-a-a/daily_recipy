class Recipe {
  String? docId;
  String? description;
  String? title;
  num? calories;
  num? prep_time;
  num? rating;
  int? servings;
  String? type;
  Map<String, String>? directions;
  List<String>? ingredients;
  String? imageUrl;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    title = data['title'];
    imageUrl = data['imageUrl'];
    description = data['description'];
    servings = data['servings'];
    type = data['type'];
    calories = data['calories'];
    rating = data['rating'];
    prep_time = data['prep_time'];
    ingredients = data['ingredients'] != null
        ? List<String>.from(data['ingredients'])
        : null;
    directions = data['directions'] != null
        ? Map<String, String>.from(data['directions'].map((e) => e.toString()))
        : null;
  }
  Map<String, dynamic> toJson() {
    return {
      'prep_time': prep_time,
      'rating': rating,
      'calories': calories,
      'directions': directions,
      'type': type,
      'servings': servings,
      'ingredients': ingredients,
      "title": title,
      "imageUrl": imageUrl,
      "description": description,
    };
  }
}
