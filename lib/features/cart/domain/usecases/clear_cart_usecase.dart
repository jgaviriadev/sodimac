import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase implements UseCase<bool, NoParams> {
  final CartRepository repository;

  ClearCartUseCase({required this.repository});

  @override
  Future<Result<bool, Failure>> call(NoParams params) async {
    final result = await repository.clear();

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}
