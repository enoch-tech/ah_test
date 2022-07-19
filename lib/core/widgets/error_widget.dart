import 'package:ah_test/core/constants/constants.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          child: Container(
            alignment: Alignment.center,
            height: 80,
            child: const Text(
              Constants.errorStateText,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      itemCount: 1,
    );
  }
}
