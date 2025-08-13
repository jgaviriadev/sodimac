import 'package:get_it/get_it.dart';

import 'core/core.dart';
import 'features/cart/data/datasources/cart_datasource.dart';
import 'features/cart/data/datasources/cart_datasource_impl.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/usecases.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/products/data/datasources/products_datasource.dart';
import 'features/products/data/datasources/products_datasource_impl.dart';
import 'features/products/data/repositories/products_repository_impl.dart';
import 'features/products/domain/repositories/products_repository.dart';
import 'features/products/domain/usecases/usecases.dart';
import 'features/products/presentation/bloc/products_bloc.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies() async {
  getIt.registerFactory(
    () => ProductsBloc(
      searchProductsUseCase: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => CartBloc(
      watchAllItemsUseCase: getIt(),
      addOrUpdateUseCase: getIt(),
      removeItemUseCase: getIt(),
      clearCartUseCase: getIt(),
      incrementQtyUseCase: getIt(),
      decrementQtyUseCase: getIt(),
    ),
  );

  // use cases
  getIt.registerLazySingleton(() => SearchProductsUseCase(repository: getIt()));

  // use cases cart
  getIt.registerLazySingleton(() => WatchAllItemsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => AddOrUpdateUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => RemoveItemUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ClearCartUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => IncrementQtyUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => DecrementQtyUseCase(repository: getIt()));

  //repositories
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      productsDatasource: getIt(),
    ),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      dataSource: getIt(),
    ),
  );

  // datasources
  getIt.registerLazySingleton<ProductsDatasource>(
    () => ProductsDatasourceImpl(
      getIt<ApiClient>(),
    ),
  );
  getIt.registerLazySingleton<CartDataSource>(
    () => CartDataSourceImpl(
      getIt<CartDao>(),
    ),
  );

  //local database - drift
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<CartDao>(() => getIt<AppDatabase>().cartDao);

  //api client
  getIt.registerLazySingleton(
    () => ApiClient(baseUrl: "https://www.homecenter.com.co"),
  );
}
