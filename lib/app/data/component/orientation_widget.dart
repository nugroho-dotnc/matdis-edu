import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;
  const OrientationWidget({super.key, required this.portrait, required this.landscape});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait? portrait : landscape;
    },);
  }
}
