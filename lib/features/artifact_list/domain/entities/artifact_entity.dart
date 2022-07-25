import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ArtifactEntity extends Equatable {
  final String objectNumber;
  final String title;
  final String longTitle;
  final String principalOrFirstMaker;
  final String webImage;
  final String headerImage;
  final List<dynamic> productionPlaces;
  final bool hasImage;
  final bool showImage;

  const ArtifactEntity(
      {required this.objectNumber,
      required this.title,
      required this.longTitle,
      required this.principalOrFirstMaker,
      required this.webImage,
      required this.headerImage,
      required this.productionPlaces,
      required this.hasImage,
      required this.showImage})
      : super();

  @override
  List<Object> get props => [objectNumber];
}
