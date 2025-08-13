part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {
  const CartStarted();
}

class _ItemsStreamEmitted extends CartEvent {
  final List<CartItemEntity> items;
  const _ItemsStreamEmitted(this.items);

  @override
  List<Object?> get props => [items];
}

class _ItemsStreamErrored extends CartEvent {
  final String message;
  const _ItemsStreamErrored(this.message);

  @override
  List<Object?> get props => [message];
}


class CartItemAddRequested extends CartEvent {
  final CartItemEntity item;
  final int qty;
  const CartItemAddRequested({required this.item, this.qty = 1});

  @override
  List<Object?> get props => [item, qty];
}

class CartItemRemoveRequested extends CartEvent {
  final String productId;
  const CartItemRemoveRequested({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class CartCleared extends CartEvent {
  const CartCleared();

   @override
  List<Object?> get props => [];
}

class CartItemIncremented extends CartEvent {
  final String id;
  const CartItemIncremented(this.id);

  @override
  List<Object?> get props => [id];
}

class CartItemDecremented extends CartEvent {
  final String id;
  const CartItemDecremented(this.id);

  @override
  List<Object?> get props => [id];
}