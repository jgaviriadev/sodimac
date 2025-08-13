import 'product_model.dart';

class ProductsPageModel {
  final List<ProductModel> items;
  final int totalCount;

  const ProductsPageModel({
    required this.items,
    required this.totalCount,
  });
}