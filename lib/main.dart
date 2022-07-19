import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/artifact_list/presentation/cubit/artifact_list_cubit.dart';
import 'features/artifact_list/presentation/pages/list_view_ui.dart';
import 'injection_container.dart';

Future<void> main() async {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AH Test App',
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ArtifactListCubit>(
              create: (BuildContext context) => ArtifactListCubit(getIt()),
            ),
            // BlocProvider<CryptoCurrencyDetailCubit>(
            //   create: (BuildContext context) => CryptoCurrencyDetailCubit(sl()),
            // ),
          ],
          child: const ArtifactListViewController(),
        ));
  }
}
