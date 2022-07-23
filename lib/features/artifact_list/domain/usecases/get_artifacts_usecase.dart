import 'package:ah_test/core/error/failures.dart';
import 'package:ah_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../entities/artifact_entity.dart';
import '../repositories/artifact_repository.dart';

class Params implements NoParams {
  int _page = 0;
  int _count = 0;
  Params(page, count) {
    _count = count;
    _page = page;
  }
}

class GetArtifactsUsecase implements UseCase<List<ArtifactEntity>, Params> {
  ArtifactRepository repository;
  GetArtifactsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ArtifactEntity>>> call(Params params) async {
    if (params._page < 0 || params._count < 0) {
      return Left(InvalidParamFailure());
    }
    return repository.getArtifacts(params._page, params._count);
  }
}
