import 'dart:convert';

import 'package:ah_test/core/error/failures.dart';
import 'package:ah_test/core/usecases/usecase.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:ah_test/features/artifact_list/domain/repositories/artifact_repository.dart';
import 'package:ah_test/features/artifact_list/domain/usecases/get_artifacts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'get_artifacts_test.mocks.dart';

class MockArtifactRepository extends Mock implements ArtifactRepository {}

void main() {
  GetArtifactsUsecase usecase;
  MockArtifactRepository mockArtifactRepository;
  final tArtifactModel =
      ArtifactModel.listFromJson(json.decode(fixture('artifacts.json')));
  final List<ArtifactEntity> tArtifactEntity = tArtifactModel;

  setUp(() {
    mockArtifactRepository = MockArtifactRepository();
    usecase = GetArtifactsUsecase(mockArtifactRepository);
  });
  group(
    "get artifact usecase",
    (() {
      test(
        'Should get artifacts list from the repository',
        () async {
          mockArtifactRepository = MockArtifactRepository();
          usecase = GetArtifactsUsecase(mockArtifactRepository);

          when(() => mockArtifactRepository.getArtifacts(0, 10))
              .thenAnswer((_) async => Right(tArtifactEntity));

          final result = await usecase(Params(0, 10));

          expect(result, Right(tArtifactEntity));

          verify(() => mockArtifactRepository.getArtifacts(0, 10));

          verifyNoMoreInteractions(mockArtifactRepository);
        },
      );

      test(
        'Should get Invalid Param Failure from the repository',
        () async {
          mockArtifactRepository = MockArtifactRepository();
          usecase = GetArtifactsUsecase(mockArtifactRepository);

          when(() => mockArtifactRepository.getArtifacts(-1, -10))
              .thenAnswer((_) async => Left(InvalidParamFailure()));

          final result = await usecase(Params(-1, -10));

          expect(result, Left(InvalidParamFailure())); // actual , expected

          //verify(() => mockArtifactRepository.getArtifacts(-1, -10));

          verifyNoMoreInteractions(mockArtifactRepository);
        },
      );
    }),
  );
}
