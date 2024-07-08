import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String path = '/home';
  static String name = 'home';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Hi'),
    );
  }
}
