import 'package:flutter/material.dart';

class RowTextField extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged;

  const RowTextField({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              child: Text(label, style: const TextStyle(fontSize: 16))),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              minLines: label == 'Bio' ? 1 : null,
              maxLines: label == 'Bio' ? 5 : 1,
              decoration: InputDecoration(
                hintText: value,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
