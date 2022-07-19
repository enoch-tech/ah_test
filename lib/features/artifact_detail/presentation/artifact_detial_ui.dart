import 'package:ah_test/core/constants/constants.dart';
import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ArtifactDetailUi extends StatelessWidget {
  final ArtifactEntity selectedArtifact;

  const ArtifactDetailUi({Key? key, required this.selectedArtifact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: key,
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                selectedArtifact.webImage,
                fit: BoxFit.fitHeight,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(child: Text(Constants.loadingStateText));
                  // You can use LinearProgressIndicator or CircularProgressIndicator instead
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Some errors occurred!'),
              ),
            ),
            Text(selectedArtifact.title),
            Text(selectedArtifact.longTitle)
          ],
        ),
      ),
    );
  }
}
