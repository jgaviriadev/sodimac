import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:sodimac/core/core.dart';
import 'package:sodimac/features/cart/domain/entities/entities.dart';
import 'package:sodimac/features/cart/domain/usecases/usecases.dart';
import 'package:sodimac/features/cart/presentation/bloc/cart_bloc.dart';

/// Mocks
class MockWatchAllItemsUseCase extends Mock implements WatchAllItemsUseCase {}

class MockAddOrUpdateUseCase extends Mock implements AddOrUpdateUseCase {}

class MockRemoveItemUseCase extends Mock implements RemoveItemUseCase {}

class MockClearCartUseCase extends Mock implements ClearCartUseCase {}

class MockIncrementQtyUseCase extends Mock implements IncrementQtyUseCase {}

class MockDecrementQtyUseCase extends Mock implements DecrementQtyUseCase {}

/// Fakes
class FakeNoParams extends Fake implements NoParams {}

class FakeAddParams extends Fake implements AddOrUpdateUseCaseParams {}

class FakeRemoveParams extends Fake implements RemoveItemUseCaseUseCaseParams {}

class FakeIncParams extends Fake implements IncrementQtyUseCaseUseCaseParams {}

class FakeDecParams extends Fake implements DecrementQtyUseCaseParams {}

/// Helper
Failure err([String m = 'falló']) => ServerFailure(message: m);

CartItemEntity item(String id, {int qty = 1}) => CartItemEntity(
  productId: id,
  description: 'Item $id',
  imageUrl: null,
  priceValue: '10',
  priceCurrency: r'$',
  qty: qty,
);

void main() {
  late MockWatchAllItemsUseCase watchAllUC;
  late MockAddOrUpdateUseCase addUC;
  late MockRemoveItemUseCase removeUC;
  late MockClearCartUseCase clearUC;
  late MockIncrementQtyUseCase incUC;
  late MockDecrementQtyUseCase decUC;

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeAddParams());
    registerFallbackValue(FakeRemoveParams());
    registerFallbackValue(FakeIncParams());
    registerFallbackValue(FakeDecParams());
  });

  setUp(() {
    watchAllUC = MockWatchAllItemsUseCase();
    addUC = MockAddOrUpdateUseCase();
    removeUC = MockRemoveItemUseCase();
    clearUC = MockClearCartUseCase();
    incUC = MockIncrementQtyUseCase();
    decUC = MockDecrementQtyUseCase();
  });

  blocTest<CartBloc, CartState>(
    'CartStarted → failure si watchAll falla',
    build: () {
      when(() => watchAllUC(any<NoParams>())).thenAnswer((_) async => Error(err('falló')));

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) => bloc.add(const CartStarted()),
    expect: () => [
      isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
      isA<CartState>().having((s) => s.status, 'status', CartStatus.failure).having((s) => s.error, 'error', 'falló'),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartStarted → success con items',
    build: () {
      final ctrl = StreamController<List<CartItemEntity>>();
      when(
        () => watchAllUC(any<NoParams>()),
      ).thenAnswer((_) async => Success(WatchAllItemsUseCaseResult(result: ctrl.stream)));
      ctrl.add([item('1')]);
      ctrl.add([item('1'), item('2')]);

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) => bloc.add(const CartStarted()),
    expect: () => [
      isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
      isA<CartState>().having((s) => s.status, 'status', CartStatus.success).having((s) => s.items.length, 'len', 1),
      isA<CartState>().having((s) => s.status, 'status', CartStatus.success).having((s) => s.items.length, 'len', 2),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartItemAddRequested → isAdding true→false y actionSuccess',
    build: () {
      final ctrl = StreamController<List<CartItemEntity>>();
      ctrl.add([]);

      when(
        () => watchAllUC(any<NoParams>()),
      ).thenAnswer((_) async => Success(WatchAllItemsUseCaseResult(result: ctrl.stream)));
      when(() => addUC(any())).thenAnswer((_) async => const Success(true));

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) async {
      bloc.add(const CartStarted());
      await Future.delayed(const Duration(milliseconds: 10));
      bloc.add(CartItemAddRequested(item: item('x'), qty: 1));
    },
    expect: () => [
      isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
      isA<CartState>().having((s) => s.status, 'status', CartStatus.success),
      isA<CartState>().having((s) => s.isAdding, 'isAdding', true),
      isA<CartState>()
          .having((s) => s.isAdding, 'isAdding', false)
          .having((s) => s.actionSuccess, 'ok', 'Producto agregado al carrito'),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartItemAddRequested → actionError si falla',
    build: () {
      when(() => addUC(any())).thenAnswer((_) async => Error(ServerFailure(message: 'Error al agregar')));

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) => bloc.add(CartItemAddRequested(item: item("2", qty: 2))),
    expect: () => [
      isA<CartState>().having((s) => s.isAdding, 'isAdding', true),
      isA<CartState>()
          .having((s) => s.isAdding, 'isAdding', false)
          .having((s) => s.actionError, 'actionError', 'Error al agregar'),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartCleared → isClearing true→false y actionSuccess',
    build: () {
      final ctrl = StreamController<List<CartItemEntity>>();
      ctrl.add([item('1')]);

      when(
        () => watchAllUC(any<NoParams>()),
      ).thenAnswer((_) async => Success(WatchAllItemsUseCaseResult(result: ctrl.stream)));
      when(() => clearUC(any())).thenAnswer((_) async => const Success(true));

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) async {
      bloc.add(const CartStarted());
      await Future.delayed(const Duration(milliseconds: 10));
      bloc.add(const CartCleared());
    },
    expect: () => [
      isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
      isA<CartState>().having((s) => s.status, 'status', CartStatus.success),
      isA<CartState>().having((s) => s.isClearing, 'isClearing', true),
      isA<CartState>()
          .having((s) => s.isClearing, 'isClearing', false)
          .having((s) => s.actionSuccess, 'ok', 'Carrito vaciado'),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartCleared → actionError si falla',
    build: () {
      when(() => clearUC(any())).thenAnswer(
        (_) async => Error(ServerFailure(message: 'Error al limpiar')),
      );

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) => bloc.add(CartCleared()),
    expect: () => [
      isA<CartState>().having((s) => s.isClearing, 'isClearing', true),
      isA<CartState>()
          .having((s) => s.isClearing, 'isClearing', false)
          .having((s) => s.actionError, 'actionError', 'Error al limpiar'),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartItemRemoveRequested → elimina y muestra success',
    build: () {
      final ctrl = StreamController<List<CartItemEntity>>();
      ctrl.add([item('x')]);

      when(
        () => watchAllUC(any<NoParams>()),
      ).thenAnswer((_) async => Success(WatchAllItemsUseCaseResult(result: ctrl.stream)));
      when(() => removeUC(any())).thenAnswer((_) async => const Success(true));

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) async {
      bloc.add(const CartStarted());
      await Future.delayed(const Duration(milliseconds: 10));
      bloc.add(const CartItemRemoveRequested(productId: 'x'));
    },
    expect: () => [
      isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
      isA<CartState>().having((s) => s.status, 'status', CartStatus.success),
      isA<CartState>().having((s) => s.actionSuccess, 'ok', 'Producto eliminado del carrito'),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartItemRemoveRequested → actionError si falla',
    build: () {
      when(() => removeUC(any())).thenAnswer(
        (_) async => Error(ServerFailure(message: 'No se pudo eliminar')),
      );
      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) => bloc.add(CartItemRemoveRequested(productId: "1")),
    expect: () => [
      isA<CartState>().having((s) => s.actionError, 'actionError', null),
      isA<CartState>().having((s) => s.actionError, 'actionError', 'No se pudo eliminar'),
    ],
  );

  blocTest<CartBloc, CartState>(
    'CartItemIncremented → isIncrementing true→false',
    build: () {
      final ctrl = StreamController<List<CartItemEntity>>();
      ctrl.add([item('1')]);

      when(
        () => watchAllUC(any<NoParams>()),
      ).thenAnswer((_) async => Success(WatchAllItemsUseCaseResult(result: ctrl.stream)));
      when(() => incUC(any())).thenAnswer((_) async => const Success(true));

      return CartBloc(
        watchAllItemsUseCase: watchAllUC,
        addOrUpdateUseCase: addUC,
        removeItemUseCase: removeUC,
        clearCartUseCase: clearUC,
        incrementQtyUseCase: incUC,
        decrementQtyUseCase: decUC,
      );
    },
    act: (bloc) async {
      bloc.add(const CartStarted());
      await Future.delayed(const Duration(milliseconds: 10));
      bloc.add(const CartItemIncremented('1'));
    },
    expect: () => [
      isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
      isA<CartState>().having((s) => s.status, 'status', CartStatus.success),
      isA<CartState>().having((s) => s.isIncrementing, 'inc', true),
      isA<CartState>().having((s) => s.isIncrementing, 'inc', false),
    ],
  );
}
