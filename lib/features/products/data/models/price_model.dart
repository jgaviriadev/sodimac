class PriceModel {
  final String? symbol;
  final String? price;
  final String? type;
  PriceModel({
    this.symbol,
    this.price,
    this.type
  });

  factory PriceModel.fromMap(Map<String, dynamic> json) => PriceModel(
    symbol: json["symbol"],
    price: json["price"],
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "symbol": symbol,
    "price": price,
  };
}