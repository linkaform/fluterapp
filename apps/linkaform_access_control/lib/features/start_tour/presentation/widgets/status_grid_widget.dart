import 'package:flutter/material.dart';
import 'package:ui_look_and_feel_module/gen/colors.gen.dart';

class StatusGridWidget extends StatelessWidget {
  const StatusGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        statusItem('Personal Dentro', '23', Icons.people),
        statusItem('Equipos Concesionados', '13', Icons.build),
        statusItem('Fallas Pendientes', '2', Icons.warning),
        statusItem('Vehículos Estacionados', '18', Icons.directions_car),
        statusItem('Gafetes Pendientes', '14', Icons.badge),
      ],
    );
  }


  Widget statusItem(String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    icon,
                    size: 27,
                    color: ColorName.colorTypeObjetosPerdidos,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
