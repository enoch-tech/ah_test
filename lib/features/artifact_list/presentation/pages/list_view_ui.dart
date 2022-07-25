// ignore_for_file: library_private_types_in_public_api

import 'package:ah_test/core/constants/constants.dart';
import 'package:ah_test/core/widgets/error_widget.dart';
import 'package:ah_test/core/widgets/initial_widget.dart';
import 'package:ah_test/core/widgets/loading_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/artifact_list_cubit.dart';
import '../cubit/artifact_list_state.dart';
import '../widgets/artifact_list_view_widget.dart';

class ArtifactListViewController extends StatefulWidget {
  const ArtifactListViewController({Key? key}) : super(key: key);

  @override
  _ArtifactListViewControllerState createState() =>
      _ArtifactListViewControllerState();
}

class _ArtifactListViewControllerState
    extends State<ArtifactListViewController> {
  late int _page = 0;
  late int _count = Constants.artifactsPerPage;
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    BlocProvider.of<ArtifactListCubit>(context).getInitialArtifactList(
      _page,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.artifacts),
      ),
      body: body(),
    );
  }

  Widget body() {
    return EasyRefresh(
      controller: _controller,
      header: const ClassicHeader(backgroundColor: Colors.blue),
      footer: const ClassicFooter(backgroundColor: Colors.blue),
      onRefresh: () async {
        setState(() {
          _page = 0;
          _count = Constants.artifactsPerPage;
        });
        BlocProvider.of<ArtifactListCubit>(context)
            .getInitialArtifactList(_page);
        // await Future.delayed(const Duration(seconds: 0));

        _controller.finishRefresh();
        _controller.resetFooter();
      },
      onLoad: () async {
        BlocProvider.of<ArtifactListCubit>(context)
            .getPaginatedArtifactList(_page);

        // if (!mounted) {
        //   return;
        // }
        _controller.finishLoad(
            _count >= 10000 ? IndicatorResult.noMore : IndicatorResult.success);
      },
      child: BlocConsumer<ArtifactListCubit, ArtifactListState>(
          builder: (context, state) {
        if (state is ArtifactListInitial) {
          return const InitialWidget();
        } else if (state is ArtifactListLoading) {
          return const LoadingWidget();
        } else if (state is ArtifactListLoaded) {
          return ArtifactListView(artifacts: state.artifactEntities.toSet());
        } else {
          return const MyErrorWidget();
        }
      }, listener: (context, state) {
        if (state is ArtifactListLoaded) {
          setState(() {
            _page += 1;
            _count += Constants.artifactsPerPage;
          });
        }
      }),
    );
  }
}
