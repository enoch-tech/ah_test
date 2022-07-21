import 'package:ah_test/core/error/exceptions.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/artifact_repository.dart';
import '../datasources/artifact_remote_datasource.dart';

class ArtifactRepositoryImpl implements ArtifactRepository {
  final ArtifactRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ArtifactRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ArtifactEntity>>> getArtifacts(
      int page, int count) async {
    try {
      if (count <= 0) {
        return Left(InvalidParamFailure());
      }
      if (await networkInfo.isConnected) {
        try {
          final remoteData = await remoteDataSource.getRemoteData(page, count);
          return Right(remoteData);
        } on Exception {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
