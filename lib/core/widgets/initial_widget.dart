import 'package:flutter/material.dart';

import '../constants/constants.dart';

class InitialWidget extends StatelessWidget {
  const InitialWidget({Key? key}) : super(key: key);

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
              Constants.initialStateText,
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
