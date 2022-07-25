import 'dart:ffi';

import 'package:ah_test/features/artifact_list/domain/entities/artifact_entity.dart';
import 'package:ah_test/features/artifact_list/presentation/widgets/artifact_row.dart';
import 'package:flutter/material.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

// List<Element> _elements = <Element>[
//   Element(DateTime(2020, 6, 24, 18), 'Got to gym', Icons.fitness_center),
//   Element(DateTime(2020, 6, 24, 9), 'Work', Icons.work),
//   Element(DateTime(2020, 6, 25, 8), 'Buy groceries', Icons.shopping_basket),
//   Element(DateTime(2020, 6, 25, 16), 'Cinema', Icons.movie),
//   Element(DateTime(2020, 6, 25, 20), 'Eat', Icons.fastfood),
//   Element(DateTime(2020, 6, 26, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 13), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 14), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 15), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 28, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 30, 12), 'Car wash', Icons.local_car_wash),
// ];

class StickyListView extends StatelessWidget {
  const StickyListView({
    required List<ArtifactEntity> artifacts,
    Key? key,
  })  : _artifacts = artifacts,
        super(key: key);

  final List<ArtifactEntity> _artifacts;

  @override
  Widget build(BuildContext context) {
    return StickyGroupedListView<ArtifactEntity, String>(
      elements: _artifacts,
      order: StickyGroupedListOrder.ASC,
      groupBy: (ArtifactEntity element) => element.principalOrFirstMaker,
      groupComparator: (String value1, String value2) =>
          value2.compareTo(value1),
      itemComparator: (ArtifactEntity element1, ArtifactEntity element2) =>
          element1.principalOrFirstMaker
              .compareTo(element2.principalOrFirstMaker),
      floatingHeader: true,
      groupSeparatorBuilder: (ArtifactEntity element) => SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              border: Border.all(
                color: Colors.blue[300]!,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Has Image ${element.hasImage}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (_, ArtifactEntity element) {
        return ArtifactRow(artifact: element);

        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(6.0),
        //   ),
        //   elevation: 8.0,
        //   margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        //   child: ListTile(
        //     contentPadding:
        //         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        //     title: Text(element.title),
        //   ),
        // );
      },
    );
  }
}
