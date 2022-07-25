import 'dart:convert';

import 'package:ah_test/core/error/failures.dart';
import 'package:ah_test/core/network/network_info.dart';
import 'package:ah_test/features/artifact_list/data/datasources/artifact_remote_datasource.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/data/repositories/artifact_repository_impl.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements ArtifactRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ArtifactRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ArtifactRepositoryImpl(mockRemoteDataSource, mockNetworkInfo);
  });

  group('getting Artifacts', () {
    var tArtifact;
    setUp(() {
      //arrange
      tArtifact =
          ArtifactModel.listFromJson(json.decode(fixture('artifacts.json')));

      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getRemoteData(0, 10))
          .thenAnswer((_) async => tArtifact);
    });
    test(
      'Should check if the device is online',
      () async {
        //act
        await repository.getArtifacts(0, 10);

        //assert
        verify(() => mockNetworkInfo.isConnected());
        verify(() => mockRemoteDataSource.getRemoteData(0, 10));
      },
    );

    test(
      'Should return data is device is online and API call is correct',
      () async {
        //act
        final actual = (await repository.getArtifacts(0, 10));

        //assert
        verify(() => mockNetworkInfo.isConnected());
        verify(() => mockRemoteDataSource.getRemoteData(0, 10));
        actual.fold((l) => {}, (r) => expect(tArtifact, r));
      },
    );
  });

  group('getting error/exceptions', () {
    var tArtifact;
    setUp(() {
      //arrange
      tArtifact =
          ArtifactModel.listFromJson(json.decode(fixture('artifacts.json')));

      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
      when(() => mockRemoteDataSource.getRemoteData(0, 10))
          .thenAnswer((_) async => tArtifact);
    });

    test(
      'Should return failure if the device is offline',
      () async {
        //act
        await repository.getArtifacts(0, 10);

        //assert
        final actual = (await repository.getArtifacts(0, 10));

        //assert
        verify(() => mockNetworkInfo.isConnected());

        actual.fold((l) => {expect(l, equals(NetworkFailure()))}, (r) => {});
      },
    );
  });
}
