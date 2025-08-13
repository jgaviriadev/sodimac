import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/cart_repository.dart';

class WatchAllItemsUseCase implements UseCase<WatchAllItemsUseCaseResult, NoParams> {
  final CartRepository repository;

  WatchAllItemsUseCase({required this.repository});

  @override
  Future<Result<WatchAllItemsUseCaseResult, Failure>> call(NoParams _) async {
    final result = await repository.watchAll();

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}

class WatchAllItemsUseCaseResult {
  final Stream<List<CartItemEntity>> result;
  const WatchAllItemsUseCaseResult({
    required this.result,
  });
}
