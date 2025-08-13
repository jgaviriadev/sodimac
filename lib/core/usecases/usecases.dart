import 'package:multiple_result/multiple_result.dart';

import '../core.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}

class NoParams {}