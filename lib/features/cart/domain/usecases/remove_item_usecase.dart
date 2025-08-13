import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class RemoveItemUseCase implements UseCase<bool, RemoveItemUseCaseUseCaseParams> {
  final CartRepository repository;

  RemoveItemUseCase({required this.repository});

  @override
  Future<Result<bool, Failure>> call(RemoveItemUseCaseUseCaseParams params) async {
    final result = await repository.remove(params.id);

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}

class RemoveItemUseCaseUseCaseParams {
  final String id;

  const RemoveItemUseCaseUseCaseParams({
    required this.id,
  });
}