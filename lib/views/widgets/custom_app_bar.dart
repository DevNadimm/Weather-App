import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Function(String) onLocationChanged;

  const CustomAppBar({super.key, required this.onLocationChanged});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _locationController =
      TextEditingController(text: 'Dhaka');
  String? _errorText;

  void _handleSearch() {
    final input = _locationController.text.trim();

    if (input.isEmpty) {
      setState(() {
        _errorText = 'Please enter a city name.';
      });
    } else {
      setState(() {
        _errorText = null;
      });
      FocusScope.of(context).unfocus();
      widget.onLocationChanged(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
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
                    textInputAction: TextInputAction.search,
                    // Set the action button to search
                    onSubmitted: (_) => _handleSearch(),
                    // Handle search on keyboard action
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
                        onPressed: _handleSearch,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Text(
              _errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
      ],
    );
  }
}
