import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class IncrementQtyUseCase implements UseCase<bool, IncrementQtyUseCaseUseCaseParams> {
  final CartRepository repository;

  IncrementQtyUseCase({required this.repository});

  @override
  Future<Result<bool, Failure>> call(IncrementQtyUseCaseUseCaseParams params) async {
    final result = await repository.incrementQty(params.id);

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}

class IncrementQtyUseCaseUseCaseParams {
  final String id;

  const IncrementQtyUseCaseUseCaseParams({
    required this.id,
  });
}
