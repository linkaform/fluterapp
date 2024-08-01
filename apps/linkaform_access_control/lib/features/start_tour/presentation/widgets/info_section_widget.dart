import 'package:flutter/material.dart';

class InfoSectionWidget extends StatelessWidget {
  const InfoSectionWidget({
    required this.title,
    required this.icon,
    required this.children,
    this.button,
    super.key,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(icon, size: 18),
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
            Visibility(
              visible: button != null,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: button,
              ),
            ),
          ],
        ),
      ],
    );
    ;
  }
}
