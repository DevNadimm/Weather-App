import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Function(String) onLocationChanged;

  const CustomAppBar({super.key, required this.onLocationChanged});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Text(
              'Weather App',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Search for a city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.08),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      widget.onLocationChanged(_locationController.text);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}