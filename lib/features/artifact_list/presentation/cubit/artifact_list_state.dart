import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ArtifactListState extends Equatable {
  const ArtifactListState();

  @override
  List<Object> get props => [];
}

class ArtifactListInitial extends ArtifactListState {}

class ArtifactListLoading extends ArtifactListState {
  const ArtifactListLoading();
}

class ArtifactListLoaded extends ArtifactListState {
  final List<ArtifactEntity> artifactEntities;
  const ArtifactListLoaded({required this.artifactEntities});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ArtifactListLoaded && o.artifactEntities == artifactEntities;
  }

  @override
  int get hashCode => artifactEntities.hashCode;
}

class ArtifactListError extends ArtifactListState {
  final String message;
  const ArtifactListError(this.message);
}
