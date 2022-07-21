import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../artifact_detail/presentation/artifact_detial_ui.dart';

class ArtifactListView extends StatefulWidget {
  Set<ArtifactEntity> artifacts;
  ArtifactListView({Key? key, required this.artifacts}) : super(key: key);

  @override
  _ArtifactListViewState createState() => _ArtifactListViewState();
}

class _ArtifactListViewState extends State<ArtifactListView> {
  late Set<ArtifactEntity> _artifacts;
  @override
  void initState() {
    super.initState();
    _artifacts = widget.artifacts;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _artifacts.addAll(widget.artifacts);
    });
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 0,
          child: GestureDetector(
              onTap: () {
                //Perform your logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArtifactDetailUi(
                          selectedArtifact: _artifacts.elementAt(index))),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            _artifacts.elementAt(index).headerImage),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      ),
                    ),
                  ), //Container
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                      _artifacts.elementAt(index).title,
                    ),
                  ),
                ],
              )),
        );
      },
      itemCount: _artifacts.length,
    );
  }
}
