part of 'cart_bloc.dart';

enum CartStatus { idle, loading, success, failure }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItemEntity> items;
  final String? error;
  final bool isAdding;
  final String? actionError;
  final String? actionSuccess;
  final bool isClearing;  
  final bool? isIncrementing; 
  final bool? isDecrementing;

  const CartState({
    this.status = CartStatus.idle,
    this.items = const [],
    this.error,
    this.isAdding = false,
    this.actionError,
    this.actionSuccess,
    this.isClearing = false,
    this.isIncrementing = false,
    this.isDecrementing = false,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItemEntity>? items,
    String? error,
    bool? isAdding,
    String? actionError,
    String? actionSuccess,
    bool? isClearing,
    bool? isIncrementing,
    bool? isDecrementing,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error,
      isAdding: isAdding ?? this.isAdding,
      actionError: actionError,
      actionSuccess: actionSuccess,
      isClearing: isClearing ?? this.isClearing,
      isIncrementing: isIncrementing ?? this.isIncrementing,
      isDecrementing: isDecrementing ?? this.isDecrementing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    error,
    isAdding,
    actionError,
    actionSuccess,
    isClearing,
    isIncrementing,
    isDecrementing,
  ];
}
