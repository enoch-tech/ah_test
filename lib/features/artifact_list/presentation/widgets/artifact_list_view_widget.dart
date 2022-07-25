// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:flutter/material.dart';
import '../../../artifact_detail/presentation/artifact_detail_ui.dart';

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
        return ArtifactRow(
          artifacts: _artifacts,
          index: index,
        );
      },
      itemCount: _artifacts.length,
    );
  }
}

class ArtifactRow extends StatelessWidget {
  const ArtifactRow({
    Key? key,
    required Set<ArtifactEntity> artifacts,
    required int index,
  })  : _artifacts = artifacts,
        _index = index,
        super(key: key);

  final Set<ArtifactEntity> _artifacts;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: GestureDetector(
        onTap: () {
          //Perform your logic here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtifactDetailUi(
                selectedArtifact: _artifacts.elementAt(_index),
              ),
            ),
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
                  image: NetworkImage(_artifacts.elementAt(_index).headerImage),
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
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
                _artifacts.elementAt(_index).title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
