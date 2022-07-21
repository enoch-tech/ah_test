import 'dart:convert';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/repositories/artifact_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tArtifactModel =
      ArtifactModel.fromJson(json.decode(fixture('artifact.json')));
  test('should be a subclass of Crypto Currency entity', () async {
    //arrange

    // act

    // assert
    expect(tArtifactModel, isA<ArtifactRepository>());
  });
}
