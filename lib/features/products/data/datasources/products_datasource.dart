import '../models/models.dart';

abstract class ProductsDatasource {
  Future<ProductsPageModel> searchProducts(String query, int page);
}