import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class DecrementQtyUseCase implements UseCase<bool, DecrementQtyUseCaseParams> {
  final CartRepository repository;

  DecrementQtyUseCase({required this.repository});

  @override
  Future<Result<bool, Failure>> call(DecrementQtyUseCaseParams params) async {
    final result = await repository.decrementQty(params.id);

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}

class DecrementQtyUseCaseParams {
  final String id;

  const DecrementQtyUseCaseParams({
    required this.id,
  });
}
