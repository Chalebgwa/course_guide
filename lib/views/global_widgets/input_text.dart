import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key, required this.label, this.onChanged, this.error, this.value})
      : super(key: key);
  final String label;
  final Function(String)? onChanged;
  final String? error;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 1),
            SizedBox(
              height: 20,
              child: TextFormField(
                initialValue: value,
                onChanged: onChanged,
                expands: false,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  errorText: error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextInput2 extends StatelessWidget {
  const TextInput2(
      {Key? key, required this.label, this.onChanged, this.error, this.value})
      : super(key: key);
  final String label;
  final Function(String)? onChanged;
  final String? error;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 1),
          SizedBox(
            height: 40,
            child: TextFormField(
              initialValue: value,
              onChanged: onChanged,
              decoration: InputDecoration(
                //fillColor: Theme.of(context).s,
                filled: true,

                border: OutlineInputBorder(),
                errorText: error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
