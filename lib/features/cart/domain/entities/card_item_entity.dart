class CartItemEntity {
  final String productId;
  final String? imageUrl;
  final String? description;
  final String? priceValue;
  final String? priceCurrency;
  final int qty;

  CartItemEntity({
    required this.productId,
    this.imageUrl,
    this.description,
    this.priceValue,
    this.priceCurrency,
    this.qty = 1,
  });
}