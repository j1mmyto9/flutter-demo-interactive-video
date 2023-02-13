import 'package:flutter/material.dart';

class XIndicator extends StatelessWidget {
  const XIndicator({this.radius = 15, super.key});
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            strokeWidth: 1.5),
      ),
    );
  }
}
