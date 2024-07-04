import 'package:flutter/material.dart';

class AdditionalInfoContainer extends StatelessWidget {
  const AdditionalInfoContainer(
      {super.key, required this.icon, required this.label, required this.num});

  final IconData icon;
  final String label;
  final String num;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 8),
            Text(
              num,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
