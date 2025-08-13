import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../../../core/core.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final WatchAllItemsUseCase watchAllItemsUseCase;
  final AddOrUpdateUseCase addOrUpdateUseCase;
  final RemoveItemUseCase removeItemUseCase;
  final ClearCartUseCase clearCartUseCase;
  final IncrementQtyUseCase incrementQtyUseCase;
  final DecrementQtyUseCase decrementQtyUseCase;

  StreamSubscription<List<CartItemEntity>>? _itemsSub;

  CartBloc({
    required this.watchAllItemsUseCase,
    required this.addOrUpdateUseCase,
    required this.removeItemUseCase,
    required this.clearCartUseCase,
    required this.incrementQtyUseCase,
    required this.decrementQtyUseCase
  }) : super(const CartState()) {
    on<CartStarted>(_onStarted);
    on<_ItemsStreamEmitted>(_onItemsStreamEmitted);
    on<_ItemsStreamErrored>(_onItemsStreamErrored);
    on<CartItemAddRequested>(_onAddRequested);
    on<CartItemRemoveRequested>(_onRemoveRequested);
    on<CartCleared>(_onCleared);
    on<CartItemIncremented>(_onCartItemIncremented);
    on<CartItemDecremented>(_onCartItemDecremented);
      
  }

  Future<void> _onStarted(CartStarted e, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading, error: null));

    final res = await watchAllItemsUseCase(NoParams());

    if (res.isError()) {
      final err = res.tryGetError();
      emit(
        state.copyWith(
          status: CartStatus.failure,
          error: err?.userMessage ?? 'No se pudo cargar el carrito.',
        ),
      );
      return;
    }

    final ok = res.tryGetSuccess()!;
    await _itemsSub?.cancel();
    _itemsSub = ok.result.listen(
      (items) => add(_ItemsStreamEmitted(items)),
      onError: (e, st) => add(
        _ItemsStreamErrored(
          e is Failure ? e.userMessage : (e?.toString() ?? 'Error desconocido'),
        ),
      ),
    );
  }

  void _onItemsStreamEmitted(_ItemsStreamEmitted e, Emitter<CartState> emit) {
    emit(
      state.copyWith(
        status: CartStatus.success,
        items: e.items,
        error: null,
      ),
    );
  }

  void _onItemsStreamErrored(_ItemsStreamErrored e, Emitter<CartState> emit) {
    emit(
      state.copyWith(
        status: CartStatus.failure,
        error: e.message,
      ),
    );
  }

  Future<void> _onAddRequested(
    CartItemAddRequested e,
    Emitter<CartState> emit,
  ) async {
    if (state.isAdding) return;
    emit(state.copyWith(isAdding: true, actionError: null));

    final res = await addOrUpdateUseCase(
      AddOrUpdateUseCaseParams(item: e.item, qty: e.qty),
    );

    if (res.isError()) {
      final err = res.tryGetError();
      emit(
        state.copyWith(
          isAdding: false,
          actionError: err?.userMessage ?? 'No se pudo agregar el producto.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isAdding: false,
        actionSuccess: 'Producto agregado al carrito',
        actionError: null,
      ),
    );
  }

  Future<void> _onRemoveRequested(
    CartItemRemoveRequested e,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(actionError: null, actionSuccess: null));
    final res = await removeItemUseCase(RemoveItemUseCaseUseCaseParams(id: e.productId));
    if (res.isError()) {
      final err = res.tryGetError();
      emit(
        state.copyWith(
          actionError: err?.userMessage ?? 'No se pudo eliminar el producto.',
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        actionSuccess: 'Producto eliminado del carrito',
      ),
    );
  }

  @override
  Future<void> close() async {
    await _itemsSub?.cancel();
    return super.close();
  }

  Future<void> _onCleared(
    CartCleared e,
    Emitter<CartState> emit,
  ) async {
    if (state.isClearing) return;
    emit(state.copyWith(isClearing: true, actionError: null, actionSuccess: null));

    final res = await clearCartUseCase(NoParams());

    if (res.isError()) {
      final err = res.tryGetError();
      emit(state.copyWith(
        isClearing: false,
        actionError: err?.userMessage ?? 'No se pudo vaciar el carrito.',
      ));
      return;
    }

    emit(state.copyWith(
      isClearing: false,
      actionSuccess: 'Carrito vaciado',
    ));
  }

  Future<void> _onCartItemIncremented(
    CartItemIncremented e,
    Emitter<CartState> emit,
  ) async {
    if (state.isIncrementing == true) return;

    emit(state.copyWith(isIncrementing: true));

    await incrementQtyUseCase(
      IncrementQtyUseCaseUseCaseParams(id: e.id),
    );

    emit(state.copyWith(isIncrementing: false));
  }

  Future<void> _onCartItemDecremented(
    CartItemDecremented e,
    Emitter<CartState> emit,
  ) async {
    if (state.isIncrementing == true) return;

    emit(state.copyWith(isIncrementing: true));

    await decrementQtyUseCase(
      DecrementQtyUseCaseParams(id: e.id),
    );

    emit(state.copyWith(isIncrementing: false));
  }


}
