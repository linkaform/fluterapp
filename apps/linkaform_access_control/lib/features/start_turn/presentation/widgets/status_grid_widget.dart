import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/gen/colors.gen.dart';

import '../providers/start_turn_providers.dart';

class StatusGridWidget extends ConsumerStatefulWidget {
  const StatusGridWidget({super.key});

  @override
  ConsumerState createState() => _StatusGridWidgetState();
}

class _StatusGridWidgetState extends ConsumerState<StatusGridWidget> {
  @override
  Widget build(BuildContext context) {
    final gridData =
        ref.watch(startTurnProvider).loadShiftEntity?.data?.boothStats;
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        statusItem(
          'Personal Dentro',
          gridData?.inInvitees.toString() ?? '',
          Icons.people,
        ),
        statusItem(
          'Equipos Concesionados',
          gridData?.articulosConcesionados.toString() ?? '',
          Icons.build,
        ),
        statusItem(
          'Fallas Pendientes',
          gridData?.incidentesPendites.toString() ?? '',
          Icons.warning,
        ),
        statusItem(
          'Vehículos Estacionados',
          gridData?.vehiculosEstacionados.toString() ?? '',
          Icons.directions_car,
        ),
        statusItem(
          'Gafetes Pendientes',
          gridData?.gefetesPendientes.toString() ?? '',
          Icons.badge,
        ),
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
