import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:formation_flutter/api/api_response.dart';
import 'package:formation_flutter/model/product.dart';

class ProductProvider extends ChangeNotifier {
  Product? _product;
  final Dio _dio = Dio();

  Product? get product => _product;

  ProductProvider() {
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      // Appel réseau avec Dio
      final response = await _dio.get(
        'https://api.formation-flutter.fr/v2/getProduct',
        queryParameters: {'barcode': '5000159484695'},
      );

      // Dio retourne déjà un Map<String, dynamic>
      final jsonData = response.data as Map<String, dynamic>;

      // Conversion Map -> ApiResponse
      final apiResponse = ApiResponse.fromJSON(jsonData);

      // Conversion ApiProduct -> Product
      if (apiResponse.response != null) {
        _product = apiResponse.response!.toProduct();
        notifyListeners();
      }
    } catch (e) {
      print('Erreur lors du chargement du produit: $e');
    }
  }
}
