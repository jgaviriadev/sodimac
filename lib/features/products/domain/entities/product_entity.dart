import 'entities.dart';

class ProductEntity {
  final List<String>? images;
  final String? desc;
  final PriceEntity? price;
  final String? rating;
  final String? productId;

  ProductEntity({
    required this.images,
    required this.desc,
    required this.price,
    required this.rating,
    required this.productId
  });
}