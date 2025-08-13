import '../../domain/entities/entities.dart';

class CartItemModel {
  final String productId;
  final String? imageUrl;
  final String? description;
  final String? priceValue;
  final String? priceCurrency;
  final int qty;

  CartItemModel({
    required this.productId,
    this.imageUrl,
    this.description,
    this.priceValue,
    this.priceCurrency,
    this.qty = 1,
  });

  CartItemEntity toEntity() => CartItemEntity(
    productId: productId,
    description: description,
    imageUrl: imageUrl,
    priceValue: priceValue,
    priceCurrency: priceCurrency,
    qty: qty,
  );

  factory CartItemModel.fromEntity(CartItemEntity e) => CartItemModel(
    productId: e.productId,
    description: e.description,
    imageUrl: e.imageUrl,
    priceValue: e.priceValue,
    priceCurrency: e.priceCurrency,
    qty: e.qty,
  );
}
