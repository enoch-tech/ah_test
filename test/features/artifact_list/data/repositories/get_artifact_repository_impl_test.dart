import 'dart:convert';

import 'package:ah_test/core/network/network_info.dart';
import 'package:ah_test/features/artifact_list/data/datasources/artifact_remote_datasource.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/data/repositories/artifact_repository_impl.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements ArtifactRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ArtifactRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ArtifactRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function body) {
    group('Device is online', () {
      setUp(() {
        mockNetworkInfo = MockNetworkInfo();
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('Device is offline', () {
      setUp(() {
        mockNetworkInfo = MockNetworkInfo();
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('Is Device Online', () {
    test(
      'Should check if the device is online',
      () async {
        //arange
        mockNetworkInfo = MockNetworkInfo();
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        mockRemoteDataSource = MockRemoteDataSource();
        mockNetworkInfo = MockNetworkInfo();
        repository = ArtifactRepositoryImpl(
            remoteDataSource: mockRemoteDataSource,
            networkInfo: mockNetworkInfo);
        //act
        repository.getArtifacts(0, 10);

        //assert
        verifyNever(mockNetworkInfo.isConnected);
      },
    );
  });

  runTestOnline(() {
    final tArtifactModels = ArtifactModel.listFromJson(
        json.decode(fixture('crypto_currencies.json')));
    final List<ArtifactEntity> tArtifacts = tArtifactModels;

    test(
      'Should return remote data when the call to remote data source is successful',
      () async {
        //arange
        mockNetworkInfo = MockNetworkInfo();
        mockRemoteDataSource = MockRemoteDataSource();
        when(mockRemoteDataSource.getRemoteData(0, 10))
            .thenAnswer((_) async => tArtifactModels);

        //act
        repository = ArtifactRepositoryImpl(
            remoteDataSource: mockRemoteDataSource,
            networkInfo: mockNetworkInfo);
        final result = await repository.getArtifacts(0, 10);

        //assert
        verify(mockRemoteDataSource.getRemoteData(0, 10));
        expect(result, equals(Right(tArtifacts)));
      },
    );

//   runTestOffline(() {
//     final tArtifactModels = CryptoCurrencyModel.listFromJson(
//         json.decode(fixture('crypto_currencies.json')));
//     final List<CryptoCurrency> tCryptoCurrencies = tArtifactModels;

//     // test(
//     //   'Should return last localy cached data when the cached data is availabale',
//     //   () async {
//     //     //arange
//     //     when(mockLocalDataSource.getCachedData())
//     //         .thenAnswer((_) async => tArtifactModels);

//     //     //act
//     //     final result = await repository.getCryptoCurrencies();

//     //     //assert
//     //     verifyZeroInteractions(mockRemoteDataSource);
//     //     verify(mockLocalDataSource.getCachedData());
//     //     expect(result, equals(Right(tCryptoCurrencies)));
//     //   },
//     // );

//   //   test(
//   //     'Should return CacheFailure when the cached data is not availabale',
//   //     () async {
//   //       //arange
//   //       when(mockLocalDataSource.getCachedData()).thenThrow(CacheException());

//   //       //act
//   //       final result = await repository.getCryptoCurrencies();

//   //       //assert
//   //       verifyZeroInteractions(mockRemoteDataSource);
//   //       verify(mockLocalDataSource.getCachedData());
//   //       expect(result, equals(Left(CacheFailure())));
//   //     },
//   //   );
//   // });
  });
}
