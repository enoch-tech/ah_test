import 'dart:convert';

import 'package:ah_test/core/usecases/usecase.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:ah_test/features/artifact_list/domain/repositories/artifact_repository.dart';
import 'package:ah_test/features/artifact_list/domain/usecases/get_artifacts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockArtifactRepository extends Mock implements ArtifactRepository {}

void main() {
  GetArtifactsUsecase usecase;
  MockArtifactRepository mockArtifactRepository;
  final tCryptoCurrencyModels =
      ArtifactModel.listFromJson(json.decode(fixture('artifacts.json')));
  final List<ArtifactEntity> tCryptoCurrencies = tCryptoCurrencyModels;
  setUp(() {
    mockArtifactRepository = MockArtifactRepository();
    usecase = GetArtifactsUsecase(mockArtifactRepository);
  });

  test(
    'Should get artifacts list from the repository',
    () async {
      mockArtifactRepository = MockArtifactRepository();

      usecase = GetArtifactsUsecase(mockArtifactRepository);

      when(mockArtifactRepository.getArtifacts(0, 10))
          .thenAnswer((_) async => Right(tCryptoCurrencies));

      final result = await usecase(Params(0, 10));

      expect(result, Right(tCryptoCurrencies));

      verify(mockArtifactRepository.getArtifacts(0, 10));

      verifyNoMoreInteractions(mockArtifactRepository);
    },
  );
}
