import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer(
      {super.key, required this.icon, required this.label, required this.temp});

  final IconData icon;
  final String temp;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            temp,
            style: const TextStyle(fontSize: 27,fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Icon(
            icon,
            size: 58,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
