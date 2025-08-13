import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class SetQtyItemUseCase implements UseCase<bool, SetQtyItemUseCaseParams> {
  final CartRepository repository;

  SetQtyItemUseCase({required this.repository});

  @override
  Future<Result<bool, Failure>> call(SetQtyItemUseCaseParams params) async {
    final result = await repository.setQty(params.id, params.qty);

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}

class SetQtyItemUseCaseParams {
  final String id;
  final int qty;

  const SetQtyItemUseCaseParams({required this.id, required this.qty});
}
