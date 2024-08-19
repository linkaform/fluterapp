import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  const InfoRowWidget({
    required this.label,
    required this.value,
    this.customStyle,
    super.key,
  });

  final String label;
  final String value;
  final TextStyle? customStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              '$label ',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Text(
              value,
              style: customStyle ?? const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
