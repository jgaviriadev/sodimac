import '../../domain/entities/entities.dart';
import 'models.dart';

class ProductModel {
  final String? productId;
  final String? displayName;
  final String? brand;
  final String? model;
  final List<PriceModel>? prices;
  final String? totalReviews;
  final String? rating;
  final List<String>? mediaUrls;

  ProductModel({
    this.productId,
    this.displayName,
    this.brand,
    this.model,
    this.prices,
    this.totalReviews,
    this.rating,
    this.mediaUrls,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    productId: json["productId"],
    displayName: json["displayName"],
    brand: json["brand"],
    model: json["model"],
    prices: json["prices"] == null ? [] : List<PriceModel>.from(json["prices"]!.map((x) => PriceModel.fromMap(x))),
    totalReviews: json["totalReviews"],
    rating: json["rating"],
    mediaUrls: json["mediaUrls"] == null ? [] : List<String>.from(json["mediaUrls"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "productId": productId,
    "displayName": displayName,
    "brand": brand,
    "model": model,
    "prices": prices == null ? [] : List<dynamic>.from(prices!.map((x) => x.toMap())),
    "totalReviews": totalReviews,
    "rating": rating,
    "mediaUrls": mediaUrls == null ? [] : List<dynamic>.from(mediaUrls!.map((x) => x)),
  };

  ProductEntity toEntity() {
    return ProductEntity(
      images: mediaUrls,
      desc: displayName,
      price: _selectPrice(),
      rating: rating,
      productId: productId,
    );
  }

  PriceEntity? _selectPrice() {
    final price = prices?.firstWhere(
      (p) => p.type == 'NORMAL',
      orElse: () => PriceModel(symbol: null, price: null, type: null),
    );
    return price != null && price.symbol != null && price.price != null
        ? PriceEntity(symbol: price.symbol, price: price.price)
        : null;
  }
}
