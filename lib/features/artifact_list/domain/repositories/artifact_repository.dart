import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/artifact_entity.dart';

abstract class ArtifactRepository {
  // all related methods will come here
  Future<Either<Failure, List<ArtifactEntity>>> getArtifacts(
      int page, int count);
}
