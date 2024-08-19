import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({
    required this.icon,
    required this.label,
    super.key,
    this.location,
  });

  final String? location;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => location != null ? context.push(location!) : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Icon(icon, size: 40, color: Colors.black),
          ),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
