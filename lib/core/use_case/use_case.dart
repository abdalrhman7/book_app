import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class UseCase<T, Parameter> {
  Future<Either<Failure, T>> call([Parameter parameter]);
}



class NoParameter {}
