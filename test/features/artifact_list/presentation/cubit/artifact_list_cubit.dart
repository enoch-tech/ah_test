import 'dart:convert';

import 'package:ah_test/core/usecases/usecase.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:ah_test/features/artifact_list/domain/usecases/get_artifacts_usecase.dart';
import 'package:ah_test/features/artifact_list/presentation/cubit/artifact_list_cubit.dart';
import 'package:ah_test/features/artifact_list/presentation/cubit/artifact_list_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetArtifactsUsecase extends Mock implements GetArtifactsUsecase {}

void main() {
  test('initialState should be Empty', () {
    MockGetArtifactsUsecase mockGetArtifactsUsecase = MockGetArtifactsUsecase();
    ArtifactListCubit cubit = ArtifactListCubit(mockGetArtifactsUsecase);
    expect(cubit.state, equals(ArtifactListInitial()));
  });

  group('GetArtifacts', () {
    final artifactsModels = ArtifactModel.listFromJson(
        json.decode(fixture('crypto_currencies.json')));
    final List<ArtifactEntity> artifacts = artifactsModels;

    test('should get data from usecase', () async {
      MockGetArtifactsUsecase mockGetArtifactsUsecase =
          MockGetArtifactsUsecase();
      ArtifactListCubit cubit = ArtifactListCubit(mockGetArtifactsUsecase);

      when(mockGetArtifactsUsecase(Params(0, 10)))
          .thenAnswer((_) async => Right(artifacts));

      cubit.getArtifactsUsecase(Params(0, 10));

      await untilCalled(mockGetArtifactsUsecase(Params(0, 10)));

      verify(mockGetArtifactsUsecase(Params(0, 10)));
    });
  });
}
