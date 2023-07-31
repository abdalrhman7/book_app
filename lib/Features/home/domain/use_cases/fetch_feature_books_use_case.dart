

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/book_entity.dart';
import '../repos/home_repo.dart';

class FetchFeatureBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchFeatureBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call(
      [int parameter = 0]) async {
    return await homeRepo.fetchFeaturedBooks(pageNumber: parameter );
  }
}

