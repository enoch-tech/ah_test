import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'package:ah_test/features/artifact_list/data/datasources/artifact_remote_datasource.dart';
import 'package:ah_test/features/artifact_list/domain/repositories/artifact_repository.dart';
import 'package:ah_test/features/artifact_list/domain/usecases/get_artifacts_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'features/artifact_list/data/repositories/artifact_repository_impl.dart';
import 'features/artifact_list/presentation/cubit/artifact_list_cubit.dart';

final getIt = GetIt.instance;
void init() async {
  //! External

  // Cubit
  getIt.registerFactory(() => ArtifactListCubit(getIt()));

  // Use Cases
  getIt.registerLazySingleton<GetArtifactsUsecase>(
      () => GetArtifactsUsecase(getIt()));

  // Repositories
  getIt.registerLazySingleton<ArtifactRepository>(() =>
      ArtifactRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()));

  // data source
  getIt.registerLazySingleton<ArtifactRemoteDataSource>(
      () => ArtifactRemoteDataSourceImpl(client: getIt()));

  //data base
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerLazySingleton<Client>(() => Client());
  getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
