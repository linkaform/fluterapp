import 'package:flutter/material.dart';

class ScanResultScreen extends StatelessWidget {
  static const String path = '/scan-result';
  static const String name = 'scanResult';

  final String code;

  const ScanResultScreen({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Pases Vigentes: 41'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('Vigentes'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Vencidos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildPassItem('Alberto Fuentes Cedillo', 'Visita General'),
                _buildPassItem('Alberto Fuentes Cedillo', 'Visita General'),
                _buildPassItem('Héctor Hernández Pilares', 'Soldador'),
                _buildPassItem('Renato Martínez Cid', 'Chófer de Camión'),
                _buildPassItem('Olga Maldonado Montes', 'Visita General'),
                _buildPassItem('Carlos Pedro Sánchez', 'Soldador'),
                _buildPassItem('Alberto Fuentes Cedillo', 'Visita General'),
                Center(
                  child: TextButton(
                    child: Text('Ver 35 elementos más'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Nuevo Pase'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menú'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Escanear'),
        ],
      ),
    );
  }

  Widget _buildPassItem(String name, String passType) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nombre: $name'),
          Text('Pase de Entrada: $passType'),
        ],
      ),
    );
  }
}