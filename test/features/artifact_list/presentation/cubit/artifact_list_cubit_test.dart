import 'dart:convert';

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
import 'artifact_list_cubit_test.mocks.dart';

class MockGetArtifactsUsecase extends Mock implements GetArtifactsUsecase {}

void main() {
  late MockGetArtifactsUsecase mockGetArtifactsUsecase;
  late ArtifactListCubit cubit;
  late List<ArtifactEntity> artifacts;

  setUp(() {
    mockGetArtifactsUsecase = MockGetArtifactsUsecase();
    cubit = ArtifactListCubit(mockGetArtifactsUsecase);
    var fileContent = fixture('artifacts.json');
    artifacts = ArtifactModel.listFromJson(json.decode(fileContent));
  });

  group('GetArtifacts', () {
    test('initialState should be Empty', () {
      expect(cubit.state, equals(ArtifactListInitial()));
    });
  });

  group('GetArtifacts', () {
    setUp(() {
      when(() => mockGetArtifactsUsecase(Params(0, 10)))
          .thenAnswer((_) async => Right(artifacts));
    });

    // test('should emit [Error] when the inpus is invalid.', () async* {
    //   //arrange
    //   when(mockInputConverter.stringToUnsignedInteger(any))
    //       .thenReturn(Left(InvalidInputFailure()));

    //   final expected = [
    //     Empty(),
    //     Error(message: INVALID_INPUT_FAILURE_MESSAGE),
    //   ];
    //   //assert later
    //   expectLater(cubit, emitsInOrder(expected));

    //   //act
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    // });

    test('Get Paginated Artifact List', () async {
      when(() => mockGetArtifactsUsecase(Params(0, 10)))
          .thenAnswer((_) async => Right(artifacts));

      var result = cubit.getPaginatedArtifactList(0);

      await untilCalled(() => mockGetArtifactsUsecase(Params(0, 10)));

      verify(() => mockGetArtifactsUsecase(Params(0, 10)))
          .called(greaterThan(0));
    });
  });
}
