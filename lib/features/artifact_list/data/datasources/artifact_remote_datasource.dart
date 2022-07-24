import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/artifact_model.dart';

abstract class ArtifactRemoteDataSource {
  /// Calls the https://data.rijksmuseum.nl/object-metadata/api endpoint.
  ///
  /// Throw a [ServerException] for all error
  Future<List<ArtifactModel>> getRemoteData(int page, int count);
}

class ArtifactRemoteDataSourceImpl implements ArtifactRemoteDataSource {
  final http.Client client;
  ArtifactRemoteDataSourceImpl({required this.client});
  @override
  Future<List<ArtifactModel>> getRemoteData(int page, int count) =>
      _getArtifactsFromFromUrl(page, count);

  Future<List<ArtifactModel>> _getArtifactsFromFromUrl(
      int page, int count) async {
    try {
      var queryParameters = {
        'key': Constants.API_KEY,
        'p': page.toString(),
        'ps': count.toString(),
        's': Constants.sortByArtist
      };
      final Uri uri = Uri.parse(
              Constants.BASE_URL + Constants.API_EN_COLLECTION) // parse string
          .replace(queryParameters: queryParameters);

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return ArtifactModel.listFromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw NotFoundException();
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }
}
