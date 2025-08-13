part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class QuerySubmitted extends ProductsEvent {
  final String query;
  const QuerySubmitted(this.query);
  @override
  List<Object?> get props => [];
}

class NextPageRequested extends ProductsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
class Refreshed extends ProductsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}