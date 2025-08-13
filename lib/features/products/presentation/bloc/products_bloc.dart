import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import 'products_state.dart';

part 'products_event.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  //Define useCases
  final SearchProductsUseCase searchProductsUseCase;

  ProductsBloc({
    required this.searchProductsUseCase,
  }) : super(const ProductsState()) {
    on<QuerySubmitted>(_onQuerySubmitted);
    on<NextPageRequested>(_onNextPageRequested, transformer: droppable());
    on<Refreshed>(_onRefreshed);
  }

  Future<void> _onQuerySubmitted(
    QuerySubmitted e,
    Emitter<ProductsState> emit,
  ) async {
    final q = e.query.trim();
    if (q.isEmpty) {
      emit(const ProductsState(status: ProductsStatus.idle));
      return;
    }
    emit(
      state.copyWith(
        status: ProductsStatus.loadingFirstPage,
        query: q,
        items: [],
        page: 0,
        hasMore: true,
        error: null,
      ),
    );

    final result = await searchProductsUseCase(
      SearchProductsUseCaseParams(query: q, page: 0),
    );

    final data = result.tryGetSuccess();

    if (result.isSuccess() && data != null) {
      final loaded = data.result.length;
      emit(
        state.copyWith(
          status: ProductsStatus.success,
          items: data.result,
          page: 1,
          totalCount: data.totalCount,
          hasMore: loaded < data.totalCount,
        ),
      );
    } else {
      final err = result.tryGetError();
      final message = err?.userMessage ?? "Ha ocurrido un error, intentalo nuevamente";
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          error: message,
          items: [],
          hasMore: false,
          totalCount: 0,
        ),
      );
    }
  }

  Future<void> _onNextPageRequested(
    NextPageRequested e,
    Emitter<ProductsState> emit,
  ) async {
    if (state.isLoadingMore ||
        !state.hasMore ||
        state.status != ProductsStatus.success) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, error: null));

    final result = await searchProductsUseCase(
      SearchProductsUseCaseParams(query: state.query, page: state.page),
    );

    final data = result.tryGetSuccess();
    if (result.isSuccess() && data != null) {
      final newItems = List<ProductEntity>.of(state.items)..addAll(data.result);
      emit(
        state.copyWith(
          items: newItems,
          page: state.page + 1,
          hasMore: newItems.length < state.totalCount,
          isLoadingMore: false,
        ),
      );
    } else {
      final err = result.tryGetError();
      final message = err?.userMessage ?? "Ha ocurrido un error, intentalo nuevamente";
      emit(state.copyWith(isLoadingMore: false, error: message));
    }
  }

  Future<void> _onRefreshed(Refreshed e, Emitter<ProductsState> emit) async {
    if (state.query.isEmpty) {
      emit(const ProductsState(status: ProductsStatus.idle));
      return;
    }
    add(QuerySubmitted(state.query));
  }
}
