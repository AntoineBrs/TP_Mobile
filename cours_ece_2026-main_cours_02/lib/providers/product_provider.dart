import 'package:flutter/material.dart';
import 'package:formation_flutter/model/product.dart';

class ProductProvider extends ChangeNotifier {
  Product? _product;

  Product? get product => _product;

  ProductProvider() {
    loadProduct();
  }

  void loadProduct() {
    // Initialisation avec des fausses données
    _product = generateProduct();
    notifyListeners();
  }
}
