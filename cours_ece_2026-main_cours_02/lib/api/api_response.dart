import 'package:formation_flutter/model/product.dart';

class ApiResponse {
  final ApiProduct? response;
  final String? error;

  ApiResponse.fromJSON(Map<String, dynamic> json)
    : response = json['response'] != null
          ? ApiProduct.fromJSON(json['response'])
          : null,
      error = json['error'];
}

class ApiProduct {
  final String barcode;
  final String? name;
  final String? altName;
  final ApiPictures? pictures;
  final String? quantity;
  final List<String>? brands;
  final List<String>? stores;
  final List<String>? countries;
  final List<String>? manufacturingCountries;
  final String? nutriScore;
  final int? novaScore;
  final int? ecoScore;
  final String? ecoScoreGrade;
  final int? nutritionScore;
  final ApiIngredients? ingredients;
  final ApiNutrientLevels? nutrientLevels;
  final ApiNutritionFacts? nutritionFacts;
  final ApiLevels? levels;
  final ApiTraces? traces;
  final Map<String, String>? additives;
  final ApiAllergens? allergens;
  final List<String>? packaging;
  final ApiAnalysis? analysis;

  ApiProduct.fromJSON(Map<String, dynamic> json)
    : barcode = json['barcode'],
      name = json['name'],
      altName = json['altName'],
      pictures = json['pictures'] != null
          ? ApiPictures.fromJSON(json['pictures'])
          : null,
      quantity = json['quantity'],
      brands = json['brands'] != null
          ? List<String>.from(json['brands'])
          : null,
      stores = json['stores'] != null
          ? List<String>.from(json['stores'])
          : null,
      countries = json['countries'] != null
          ? List<String>.from(json['countries'])
          : null,
      manufacturingCountries = json['manufacturingCountries'] != null
          ? List<String>.from(json['manufacturingCountries'])
          : null,
      nutriScore = json['nutriScore'],
      novaScore = json['novaScore'],
      ecoScore = json['ecoScore'],
      ecoScoreGrade = json['ecoScoreGrade'],
      nutritionScore = json['nutritionScore'],
      ingredients = json['ingredients'] != null
          ? ApiIngredients.fromJSON(json['ingredients'])
          : null,
      nutrientLevels = json['nutrientLevels'] != null
          ? ApiNutrientLevels.fromJSON(json['nutrientLevels'])
          : null,
      nutritionFacts = json['nutritionFacts'] != null
          ? ApiNutritionFacts.fromJSON(json['nutritionFacts'])
          : null,
      levels = json['levels'] != null
          ? ApiLevels.fromJSON(json['levels'])
          : null,
      traces = json['traces'] != null
          ? ApiTraces.fromJSON(json['traces'])
          : null,
      additives = json['additives'] != null
          ? Map<String, String>.from(json['additives'])
          : null,
      allergens = json['allergens'] != null
          ? ApiAllergens.fromJSON(json['allergens'])
          : null,
      packaging = json['packaging'] != null
          ? List<String>.from(json['packaging'])
          : null,
      analysis = json['analysis'] != null
          ? ApiAnalysis.fromJSON(json['analysis'])
          : null;

  // Convertisseur vers l'objet Product
  Product toProduct() {
    return Product(
      barcode: barcode,
      name: name,
      altName: altName,
      picture: pictures?.product ?? pictures?.front,
      quantity: quantity,
      brands: brands,
      manufacturingCountries: manufacturingCountries,
      nutriScore: _parseNutriScore(nutriScore),
      nutriScoreLevels: levels?.toProductNutriScoreLevels(),
      novaScore: _parseNovaScore(novaScore),
      greenScore: _parseGreenScore(ecoScoreGrade),
      ingredients: ingredients?.list,
      ingredientsWithAllergens: ingredients?.withAllergens,
      traces: traces?.list,
      allergens: allergens?.list,
      additives: additives,
      nutrientLevels: nutrientLevels?.toNutrientLevels(),
      nutritionFacts: nutritionFacts?.toNutritionFacts(),
      ingredientsFromPalmOil: ingredients?.containsPalmOil,
      containsPalmOil: ProductAnalysis.fromString(analysis?.palmOil),
      isVegan: ProductAnalysis.fromString(analysis?.vegan),
      isVegetarian: ProductAnalysis.fromString(analysis?.vegetarian),
    );
  }

  ProductNutriScore _parseNutriScore(String? score) {
    return switch (score?.toUpperCase()) {
      'A' => ProductNutriScore.A,
      'B' => ProductNutriScore.B,
      'C' => ProductNutriScore.C,
      'D' => ProductNutriScore.D,
      'E' => ProductNutriScore.E,
      _ => ProductNutriScore.unknown,
    };
  }

  ProductNovaScore _parseNovaScore(int? score) {
    return switch (score) {
      1 => ProductNovaScore.group1,
      2 => ProductNovaScore.group2,
      3 => ProductNovaScore.group3,
      4 => ProductNovaScore.group4,
      _ => ProductNovaScore.unknown,
    };
  }

  ProductGreenScore _parseGreenScore(String? score) {
    return switch (score?.toUpperCase()) {
      'A+' => ProductGreenScore.APlus,
      'A' => ProductGreenScore.A,
      'B' => ProductGreenScore.B,
      'C' => ProductGreenScore.C,
      'D' => ProductGreenScore.D,
      'E' => ProductGreenScore.E,
      'F' => ProductGreenScore.F,
      _ => ProductGreenScore.unknown,
    };
  }
}

class ApiPictures {
  final String? product;
  final String? front;
  final String? ingredients;
  final String? nutrition;

  ApiPictures.fromJSON(Map<String, dynamic> json)
    : product = json['product'],
      front = json['front'],
      ingredients = json['ingredients'],
      nutrition = json['nutrition'];
}

class ApiIngredients {
  final bool? containsPalmOil;
  final List<String>? list;
  final String? withAllergens;

  ApiIngredients.fromJSON(Map<String, dynamic> json)
    : containsPalmOil = json['containsPalmOil'],
      list = json['list'] != null ? List<String>.from(json['list']) : null,
      withAllergens = json['withAllergens'];
}

class ApiNutrientLevels {
  final ApiNutrientLevel? fat;
  final ApiNutrientLevel? salt;
  final ApiNutrientLevel? saturatedFat;
  final ApiNutrientLevel? sugars;

  ApiNutrientLevels.fromJSON(Map<String, dynamic> json)
    : fat = json['fat'] != null ? ApiNutrientLevel.fromJSON(json['fat']) : null,
      salt = json['salt'] != null
          ? ApiNutrientLevel.fromJSON(json['salt'])
          : null,
      saturatedFat = json['saturatedFat'] != null
          ? ApiNutrientLevel.fromJSON(json['saturatedFat'])
          : null,
      sugars = json['sugars'] != null
          ? ApiNutrientLevel.fromJSON(json['sugars'])
          : null;

  NutrientLevels toNutrientLevels() {
    return NutrientLevels(
      fat: fat?.level,
      salt: salt?.level,
      saturatedFat: saturatedFat?.level,
      sugars: sugars?.level,
    );
  }
}

class ApiNutrientLevel {
  final String? level;
  final double? per100g;

  ApiNutrientLevel.fromJSON(Map<String, dynamic> json)
    : level = json['level'],
      per100g = json['per100g']?.toDouble();
}

class ApiNutritionFacts {
  final String? servingSize;
  final ApiNutriment? calories;
  final ApiNutriment? fat;
  final ApiNutriment? saturatedFat;
  final ApiNutriment? carbohydrate;
  final ApiNutriment? sugar;
  final ApiNutriment? fiber;
  final ApiNutriment? proteins;
  final ApiNutriment? sodium;
  final ApiNutriment? salt;
  final ApiNutriment? energy;

  ApiNutritionFacts.fromJSON(Map<String, dynamic> json)
    : servingSize = json['servingSize'],
      calories = json['calories'] != null
          ? ApiNutriment.fromJSON(json['calories'])
          : null,
      fat = json['fat'] != null ? ApiNutriment.fromJSON(json['fat']) : null,
      saturatedFat = json['saturatedFat'] != null
          ? ApiNutriment.fromJSON(json['saturatedFat'])
          : null,
      carbohydrate = json['carbohydrate'] != null
          ? ApiNutriment.fromJSON(json['carbohydrate'])
          : null,
      sugar = json['sugar'] != null
          ? ApiNutriment.fromJSON(json['sugar'])
          : null,
      fiber = json['fiber'] != null
          ? ApiNutriment.fromJSON(json['fiber'])
          : null,
      proteins = json['proteins'] != null
          ? ApiNutriment.fromJSON(json['proteins'])
          : null,
      sodium = json['sodium'] != null
          ? ApiNutriment.fromJSON(json['sodium'])
          : null,
      salt = json['salt'] != null ? ApiNutriment.fromJSON(json['salt']) : null,
      energy = json['energy'] != null
          ? ApiNutriment.fromJSON(json['energy'])
          : null;

  NutritionFacts toNutritionFacts() {
    return NutritionFacts(
      servingSize: servingSize ?? '100g',
      calories: calories?.toNutriment(),
      fat: fat?.toNutriment(),
      saturatedFat: saturatedFat?.toNutriment(),
      carbohydrate: carbohydrate?.toNutriment(),
      sugar: sugar?.toNutriment(),
      fiber: fiber?.toNutriment(),
      proteins: proteins?.toNutriment(),
      sodium: sodium?.toNutriment(),
      salt: salt?.toNutriment(),
      energy: energy?.toNutriment(),
    );
  }
}

class ApiNutriment {
  final String? unit;
  final String? perServing;
  final String? per100g;

  ApiNutriment.fromJSON(Map<String, dynamic> json)
    : unit = json['unit'],
      perServing = json['perServing']?.toString(),
      per100g = json['per100g']?.toString();

  Nutriment toNutriment() {
    return Nutriment(
      unit: unit ?? '',
      perServing: perServing,
      per100g: per100g,
    );
  }
}

class ApiLevels {
  final ApiLevel? energy;
  final ApiLevel? fiber;
  final ApiLevel? fruitsVegetablesLegumes;
  final ApiLevel? proteins;
  final ApiLevel? salt;
  final ApiLevel? saturatedFat;
  final ApiLevel? sugars;

  ApiLevels.fromJSON(Map<String, dynamic> json)
    : energy = json['energy'] != null
          ? ApiLevel.fromJSON(json['energy'])
          : null,
      fiber = json['fiber'] != null ? ApiLevel.fromJSON(json['fiber']) : null,
      fruitsVegetablesLegumes = json['fruitsVegetablesLegumes'] != null
          ? ApiLevel.fromJSON(json['fruitsVegetablesLegumes'])
          : null,
      proteins = json['proteins'] != null
          ? ApiLevel.fromJSON(json['proteins'])
          : null,
      salt = json['salt'] != null ? ApiLevel.fromJSON(json['salt']) : null,
      saturatedFat = json['saturatedFat'] != null
          ? ApiLevel.fromJSON(json['saturatedFat'])
          : null,
      sugars = json['sugars'] != null
          ? ApiLevel.fromJSON(json['sugars'])
          : null;

  ProductNutriScoreLevels? toProductNutriScoreLevels() {
    if (energy == null &&
        fiber == null &&
        fruitsVegetablesLegumes == null &&
        proteins == null &&
        salt == null &&
        saturatedFat == null &&
        sugars == null) {
      return null;
    }

    return ProductNutriScoreLevels(
      energy: energy?.toProductNutriScoreLevel(),
      fiber: fiber?.toProductNutriScoreLevel(),
      fruitsVegetablesLegumes: fruitsVegetablesLegumes
          ?.toProductNutriScoreLevel(),
      proteins: proteins?.toProductNutriScoreLevel(),
      salt: salt?.toProductNutriScoreLevel(),
      saturatedFat: saturatedFat?.toProductNutriScoreLevel(),
      sugars: sugars?.toProductNutriScoreLevel(),
    );
  }
}

class ApiLevel {
  final double? points;
  final double? maxPoints;
  final String? unit;
  final double? value;
  final String? type;

  ApiLevel.fromJSON(Map<String, dynamic> json)
    : points = json['points']?.toDouble(),
      maxPoints = json['maxPoints']?.toDouble(),
      unit = json['unit'],
      value = json['value']?.toDouble(),
      type = json['type'];

  ProductNutriScoreLevel? toProductNutriScoreLevel() {
    if (points == null || maxPoints == null || unit == null || value == null) {
      return null;
    }

    return ProductNutriScoreLevel(
      points: points!,
      maxPoints: maxPoints!,
      unit: unit!,
      value: value!,
      type: _parseType(type),
    );
  }

  ProductNutriScoreLevelType _parseType(String? type) {
    return switch (type) {
      'positive' => ProductNutriScoreLevelType.positive,
      'negative' => ProductNutriScoreLevelType.negative,
      _ => ProductNutriScoreLevelType.unknown,
    };
  }
}

class ApiTraces {
  final List<String>? list;

  ApiTraces.fromJSON(Map<String, dynamic> json)
    : list = json['list'] != null ? List<String>.from(json['list']) : null;
}

class ApiAllergens {
  final List<String>? list;

  ApiAllergens.fromJSON(Map<String, dynamic> json)
    : list = json['list'] != null ? List<String>.from(json['list']) : null;
}

class ApiAnalysis {
  final String? palmOil;
  final String? vegan;
  final String? vegetarian;

  ApiAnalysis.fromJSON(Map<String, dynamic> json)
    : palmOil = json['palmOil'],
      vegan = json['vegan'],
      vegetarian = json['vegetarian'];
}
