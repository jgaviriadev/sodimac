
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/cart_repository.dart';



class AddOrUpdateUseCase implements UseCase<bool, AddOrUpdateUseCaseParams> {
  final CartRepository repository;

  AddOrUpdateUseCase({required this.repository});

  @override
  Future<Result<bool, Failure>> call(AddOrUpdateUseCaseParams params) async {
    final result = await repository.addOrUpdate(
      params.item,
      qty: params.qty
    );

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}

class AddOrUpdateUseCaseParams {
  final CartItemEntity item;
  final int qty;

  const AddOrUpdateUseCaseParams({required this.item, required this.qty,});
}
