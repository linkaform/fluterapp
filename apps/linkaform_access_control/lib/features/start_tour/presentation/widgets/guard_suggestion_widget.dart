import 'package:flutter/material.dart';

class GuardSuggestionWidget extends StatelessWidget {
  const GuardSuggestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Guardias de Apoyo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Text('Sugerencias',
            style: TextStyle(fontWeight: FontWeight.bold)),
        guardTile('Fernando López García'),
        guardTile('Juan Carlos Rodríguez Martínez'),
        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Ver 1 elemento más',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue[700],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget guardTile(String name) {
    return ListTile(
      leading: const Icon(Icons.person_outline),
      title: Text(name),
      trailing: const Text('Disponible'),
    );
  }
}
