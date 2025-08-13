import '../../../../core/core.dart';
import '../models/models.dart';
import 'products_datasource.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  final ApiClient _client;

  ProductsDatasourceImpl(this._client);
  
  
  @override
  Future<ProductsPageModel> searchProducts(String query, int page) async {
    final json = await _client.getJson(
      ServerApiConstants.searchEndpoint,
      query: {
        'priceGroup': 10,
        'q': query,
        'currentpage': page,
      },
    );

    final data = (json['data'] as Map<String, dynamic>?) ?? const {};
    final results = (data['results'] as List?) ?? const [];
    final products =  results.map((e) => ProductModel.fromMap(e),).toList();

    final pagination = (data['pagination'] as Map<String, dynamic>?) ?? const {};
    final totalCount = pagination['count'] as int? ?? 0;

    return ProductsPageModel(
      items: products,
      totalCount: totalCount
    );
  }
}