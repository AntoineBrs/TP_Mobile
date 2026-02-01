import 'package:flutter/material.dart';
import 'package:formation_flutter/model/product.dart';

class ProductInheritedWidget extends InheritedWidget {
  final Product product;

  const ProductInheritedWidget({
    super.key,
    required this.product,
    required super.child,
  });

  static ProductInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ProductInheritedWidget oldWidget) {
    return oldWidget.product != product;
  }
}
