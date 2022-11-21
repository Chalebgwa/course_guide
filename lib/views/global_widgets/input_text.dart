import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({Key? key, required this.label, this.onChanged, this.error, this.value}) : super(key: key);
  final String label;
  final String? Function(String?)? onChanged;
  final String? error;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorText: error,
            ),
          ),
        ],
      ),
    );
  }
}
