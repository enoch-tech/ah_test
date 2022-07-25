import 'dart:convert';
import 'package:ah_test/features/artifact_list/data/models/artifact_model.dart';
import 'package:ah_test/features/artifact_list/domain/repositories/artifact_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  test('should pass for valid json', () async {
    //arrange
    final tArtifactModel =
        ArtifactModel.fromJson(json.decode(fixture('artifact.json')));
    expect(tArtifactModel, isNotNull);
  });

  test('should return object for dirty json', () async {
    //arrange
    final tArtifactModel =
        ArtifactModel.fromJson(json.decode(fixture('artifact_dirty.json')));

    expect(tArtifactModel, isNotNull);
  });
}
