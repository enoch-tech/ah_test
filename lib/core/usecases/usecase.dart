import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class UseCase<Type, NoParams> {
  Future<Either<Failure, Type>> call(NoParams noParams);
}

class NoParams {}
