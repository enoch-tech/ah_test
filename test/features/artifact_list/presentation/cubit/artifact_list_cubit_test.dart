import 'dart:convert';

import 'package:ah_test/core/error/failures.dart';
import 'package:ah_test/core/usecases/usecase.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:ah_test/features/artifact_list/domain/usecases/get_artifacts_usecase.dart';
import 'package:ah_test/features/artifact_list/presentation/cubit/artifact_list_cubit.dart';
import 'package:ah_test/features/artifact_list/presentation/cubit/artifact_list_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetArtifactsUsecase extends Mock implements GetArtifactsUsecase {}

void main() {
  late ArtifactListCubit cubit;
  late MockGetArtifactsUsecase mockGetArtifactsUsecase;
  late List<ArtifactEntity> artifacts;
  var fileContent = fixture('artifacts.json');
  artifacts = ArtifactModel.listFromJson(json.decode(fileContent));

  setUp(() {
    mockGetArtifactsUsecase = MockGetArtifactsUsecase();
    cubit = ArtifactListCubit(mockGetArtifactsUsecase);
  });

  group('GetArtifacts', () {
    setUp(() {
      when(() => mockGetArtifactsUsecase(Params(0, 10)))
          .thenAnswer((_) async => Right(artifacts));
    });
    test('initialState should be Empty', () {
      expect(cubit.state, equals(ArtifactListInitial()));
    });

    test('should emit [Error] when the input is invalid.', () async* {
      //arrange
      when(() => mockGetArtifactsUsecase(any()))
          .thenAnswer((_) async => Left(InvalidParamFailure()));

      final expected = [
        ArtifactListInitial(),
        const ArtifactListLoading(),
        const ArtifactListLoaded(artifactEntities: []),
      ];
      //assert later
      expectLater(cubit, emitsInOrder(expected));
    });

    test('Get Paginated Artifact List', () async* {
      mockGetArtifactsUsecase = MockGetArtifactsUsecase();

      cubit = ArtifactListCubit(mockGetArtifactsUsecase);

      when(() => mockGetArtifactsUsecase(Params(0, 10)))
          .thenAnswer((_) async => Right(artifacts));

      final result = await cubit.getPaginatedArtifactList(0);

      await untilCalled(() => mockGetArtifactsUsecase(Params(0, 10)));

      verify(() => mockGetArtifactsUsecase(Params(0, 10)))
          .called(greaterThan(0));
    });

    test('Get Paginated Artifact List', () async* {
      mockGetArtifactsUsecase = MockGetArtifactsUsecase();

      cubit = ArtifactListCubit(mockGetArtifactsUsecase);

      when(() async => mockGetArtifactsUsecase(Params(-1, 10)))
          .thenAnswer((_) async => Right(artifacts));

      final result = await cubit.getPaginatedArtifactList(-1);

      await untilCalled(() => mockGetArtifactsUsecase(Params(-1, 10)));

      verifyNever(() => mockGetArtifactsUsecase(Params(-1, 10)));
    });
  });
}
