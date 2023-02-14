import 'package:flutter/material.dart';

class QButtonIcon extends StatelessWidget {
  const QButtonIcon({super.key, required this.iconData, required this.onTap});
  final IconData iconData;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(iconData, color: Colors.white, size: 16),
              )),
        ),
      ),
    );
  }
}
