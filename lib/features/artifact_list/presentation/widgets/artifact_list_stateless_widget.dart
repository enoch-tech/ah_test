// import 'package:flutter/material.dart';

// import 'package:ah_test/features/artifact_detail/presentation/artifact_detial_ui.dart';
// import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';

// class ArtifactListView extends StatelessWidget {
//   late Set<ArtifactEntity> artifacts;

//   ArtifactListView({
//     Key? key,
//     required this.artifacts,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemBuilder: (BuildContext context, int index) {
//         artifacts.addAll(artifacts);
//         return Card(
//           elevation: 0,
//           child: GestureDetector(
//               onTap: () {
//                 //Perform your logic here
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ArtifactDetailUi(
//                           selectedArtifact: artifacts.elementAt(index))),
//                 );
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: <Widget>[
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(
//                             artifacts.elementAt(index).headerImage),
//                         fit: BoxFit.fitWidth,
//                         alignment: Alignment.center,
//                       ),
//                     ),
//                   ), //Container
//                   Positioned(
//                     width: MediaQuery.of(context).size.width,
//                     child: Text(
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                       textAlign: TextAlign.center,
//                       artifacts.elementAt(index).title,
//                     ),
//                   ),
//                 ],
//               )),
//         );
//       },
//       itemCount: artifacts.length,
//     );
//   }
// }
