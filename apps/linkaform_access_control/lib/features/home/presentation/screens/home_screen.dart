// static String path = '/home';
// static String name = 'home';

import 'package:flutter/material.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String path = '/home';
  static String name = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            _buildGridItem(Icons.search, 'Buscar Pase'),
            _buildGridItem(Icons.person, 'Visitas'),
            _buildGridItem(Icons.inventory, 'Paquetes'),
            _buildGridItem(Icons.note, 'Notas'),
            _buildGridItem(Icons.route, 'Rondines'),
            _buildGridItem(Icons.warning, 'Incidencias'),
            _buildGridItem(Icons.error, 'Fallas'),
            _buildGridItem(Icons.build, 'Equipos'),
            _buildGridItem(Icons.volume_up, 'Objetos Perdidos'),
            _buildGridItem(Icons.settings, 'Configuración'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Turno',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Nuevo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Salir',
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label) {
    return Column(
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
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
