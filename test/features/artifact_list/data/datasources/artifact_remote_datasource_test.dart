import 'dart:convert';
import 'dart:io';
import 'package:ah_test/core/constants/constants.dart';
import 'package:ah_test/features/artifact_list/data/datasources/artifact_remote_datasource.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ArtifactRemoteDataSourceImpl remoteDataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = ArtifactRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() async {
    var stringJson = fixture('artifacts.json');

    //mockHttpClient = MockHttpClient();
    var queryParameters = {
      'key': Constants.API_KEY,
      'p': 0.toString(),
      'ps': 10.toString()
    };

    final Uri uri = Uri.parse(Constants.BASE_URL + Constants.API_EN_COLLECTION)
        .replace(queryParameters: queryParameters);

    when(() async => mockHttpClient.get(uri))
        .thenAnswer((_) async => http.Response(fixture('artifacts.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    var queryParameters = {
      'key': Constants.API_KEY,
      'p': 0.toString(),
      'ps': 10.toString()
    };
    final Uri uri = Uri.parse(Constants.BASE_URL + Constants.API_EN_COLLECTION)
        .replace(queryParameters: queryParameters);
    when(() async => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getArtifactList', () {
    var tArtifact;
    setUp(() {
      setUpMockHttpClientSuccess200();
      setUpMockHttpClientFailure404();
      tArtifact =
          ArtifactModel.listFromJson(json.decode(fixture('artifacts.json')));
    });

    //   test('''should perform a GET request on a URL with number
    //  being the endpoint and with application/json header''', () async {
    //     var result = remoteDataSource.getRemoteData(0, 10);

    //     var queryParameters = {
    //       'key': Constants.API_KEY,
    //       'p': 0.toString(),
    //       'ps': 10.toString()
    //     };
    //     final Uri uri =
    //         Uri.parse(Constants.BASE_URL + Constants.API_EN_COLLECTION)
    //             .replace(queryParameters: queryParameters);

    //     verify(() async => mockHttpClient.get(uri)).called(greaterThan(0));
    //   });

    test('should return artifact when the response code 200', () async {
      final result = await remoteDataSource.getRemoteData(0, 10);

      expect(result, equals(tArtifact));
    });

    test('should return ServerException when the response code other then 200',
        () async {
      final call = remoteDataSource.getRemoteData;
      expect(() async => call, throwsException);
    });
  });
}
