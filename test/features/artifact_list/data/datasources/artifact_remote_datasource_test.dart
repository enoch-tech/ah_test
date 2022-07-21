import 'dart:convert';
import 'dart:io';
import 'package:ah_test/core/constants/constants.dart';
import 'package:ah_test/features/artifact_list/data/datasources/artifact_remote_datasource.dart';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ArtifactRemoteDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;

  void setUpMockHttpClientSuccess200() {
    mockHttpClient = MockHttpClient();
    when(mockHttpClient.get(Uri(), headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('artifacts.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    mockHttpClient = MockHttpClient();
    when(mockHttpClient.get(Uri(), headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getArtifactList', () {
    final tArtifact =
        ArtifactModel.listFromJson(json.decode(fixture('artifacts.json')));

    test('''should perform a GET request on a URL with number
   being the endpoint and with application/json header''', () {
      setUpMockHttpClientSuccess200();
      mockHttpClient = MockHttpClient();
      remoteDataSource = ArtifactRemoteDataSourceImpl(client: mockHttpClient);
      remoteDataSource.getRemoteData(0, 10);
      var queryParameters = {'key': Constants.API_KEY, 'p': 0, 'ps': 10};
      final Uri uri =
          Uri.parse(Constants.BASE_URL + Constants.API_EN_COLLECTION)
              .replace(queryParameters: queryParameters);

      verify(mockHttpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return crypto currencies when the response code 200',
        () async {
      setUpMockHttpClientSuccess200();
      mockHttpClient = MockHttpClient();
      remoteDataSource = ArtifactRemoteDataSourceImpl(client: mockHttpClient);
      final result = await remoteDataSource.getRemoteData(0, 10);
      expect(result, equals(tArtifact));
    });

    test('should return ServerException when the response code other then 200',
        () async {
      setUpMockHttpClientFailure404();
      mockHttpClient = MockHttpClient();
      remoteDataSource = ArtifactRemoteDataSourceImpl(client: mockHttpClient);
      final call = remoteDataSource.getRemoteData;
      expect(() => call(0, 10), throwsException);
    });
  });
}
