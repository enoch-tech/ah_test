import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// ignore: must_be_immutable
class ArtifactModel extends ArtifactEntity {
  const ArtifactModel(
      {required String objectNumber,
      required String title,
      required String longTitle,
      required String principalOrFirstMaker,
      required String webImage,
      required String headerImage,
      required List<dynamic> productionPlaces,
      required bool hasImage,
      required bool showImage})
      : super(
          objectNumber: objectNumber,
          title: title,
          longTitle: longTitle,
          principalOrFirstMaker: principalOrFirstMaker,
          webImage: webImage,
          headerImage: headerImage,
          productionPlaces: productionPlaces,
          hasImage: hasImage,
          showImage: showImage,
        );

  factory ArtifactModel.fromJson(Map<String, dynamic> json) {
    // todo i want to put data checks while reading data.

    var artifact = ArtifactModel(
      objectNumber: json['objectNumber'],
      title: json['title'],
      longTitle: json['longTitle'],
      principalOrFirstMaker: json['principalOrFirstMaker'],
      webImage: json['webImage']['url'],
      headerImage: json['headerImage']['url'],
      productionPlaces: json['productionPlaces'],
      hasImage: json['hasImage'],
      showImage: json['showImage'],
    );
    return artifact;
  }

  // objectNumber: json['objectNumber'],
  //     artObjects: json['objectNumber'],
  //     symbol: json['symbol'],
  //     name: json['name'],
  //     unitPrice: (json['quote']['USD']['price'] as num).toDouble(),
  //     lastUpdate: DateTime.tryParse(json['quote']['USD']['last_updated'])

  static List<ArtifactModel> listFromJson(Map<String, dynamic> json) {
    List<ArtifactModel> list = [];
    final jsonList = json['artObjects'];
    for (var artifactJson in jsonList) {
      var artifact = ArtifactModel.fromJson(artifactJson);
      // we can make this check more good
      if (!list.contains(artifact)) {
        list.add(artifact);
      }
    }
    return list;
  }

  // Map<String, dynamic> toJson() {
  //   return {'id': id, 'symbol': symbol, 'name': name};
  // }
}
