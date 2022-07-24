import 'package:ah_test/core/constants/constants.dart';
import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_artifacts_usecase.dart';
import 'artifact_list_state.dart';

class ArtifactListCubit extends Cubit<ArtifactListState> {
  final GetArtifactsUsecase getArtifactsUsecase;
  ArtifactListCubit(this.getArtifactsUsecase) : super(ArtifactListInitial());

  Future<void> getPaginatedArtifactList(page,
      {count = Constants.artifactsPerPage}) async {
    if (page < 0 || count < 0) emit(const ArtifactListError(''));

    var p = Params(page, count);
    try {
      final artifactResponse = await getArtifactsUsecase(p);
      artifactResponse.fold(
        (failure) => emit(const ArtifactListError('')),
        (success) => emit(ArtifactListLoaded(artifactEntities: success)),
      );
    } on Exception {
      emit(const ArtifactListError(''));
    }
  }

  Future<void> getInitialArtifactList(page,
      {count = Constants.artifactsPerPage}) async {
    if (page < 0 || count < 0) emit(const ArtifactListError(''));
    Params p = Params(page, count);
    try {
      emit(const ArtifactListLoading());
      final artifactResponse = await getArtifactsUsecase(p);
      artifactResponse.fold(
        (failure) => emit(const ArtifactListError('')),
        (success) => emit(ArtifactListLoaded(artifactEntities: success)),
      );
    } on Exception {
      emit(const ArtifactListError(''));
    }
  }
}
