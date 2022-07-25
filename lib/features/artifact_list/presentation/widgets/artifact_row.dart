import 'package:ah_test/features/artifact_detail/presentation/artifact_detail_ui.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:flutter/material.dart';

class ArtifactRow extends StatelessWidget {
  const ArtifactRow({
    Key? key,
    required ArtifactEntity artifact,
  })  : _artifact = artifact,
        super(key: key);

  final ArtifactEntity _artifact;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          //Perform your logic here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtifactDetailUi(
                selectedArtifact: _artifact,
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
                  image: NetworkImage(_artifact.headerImage),
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
                _artifact.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
