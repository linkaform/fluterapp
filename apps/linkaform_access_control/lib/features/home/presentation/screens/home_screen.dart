import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/providers/home_providers.dart';
import 'package:linkaform_access_control/features/scanner/presentation/screens/scan_qr_screen.dart';
import 'package:linkaform_access_control/features/scanner/presentation/screens/entry_passes_screen.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/screens/start_turn_screen.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

import '../widgets/grid_item_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String path = '/home';
  static const String name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guardHouseValue = ref.watch(guardHouseSelectedValueProvider);
    final guardHouseList = ref.watch(guardHouseListProvider);

    return Scaffold(
      appBar: HomeAppBar(
        bothValue:
            '${guardHouseValue?.location ?? ''} - ${guardHouseValue?.area ?? ''}',
        // onSelected: (selectedGuardHouse) {
        //   ref.read(guardHouseValueProvider.notifier).state = selectedGuardHouse;
        // },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: const [
            GridItemWidget(
              icon: Icons.search,
              label: 'Buscar Pase',
              location: EntryPassesScreen.path,
            ),
            GridItemWidget(icon: Icons.person, label: 'Visitas'),
            GridItemWidget(icon: Icons.inventory, label: 'Paquetes'),
            GridItemWidget(icon: Icons.note, label: 'Notas'),
            GridItemWidget(icon: Icons.route, label: 'Rondines'),
            GridItemWidget(icon: Icons.warning, label: 'Incidencias'),
            GridItemWidget(icon: Icons.error, label: 'Fallas'),
            GridItemWidget(icon: Icons.build, label: 'Equipos'),
            GridItemWidget(icon: Icons.volume_up, label: 'Objetos Perdidos'),
            GridItemWidget(icon: Icons.settings, label: 'Configuración'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Turno',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Nuevo',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () => context.push(ScanQrScreen.path),
                child: const Icon(Icons.qr_code_scanner)),
            label: 'Escanear',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Salir',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Colors.blue,
        onPressed: () => context.push(StartTurnScreen.path),
        child: const Icon(
          Icons.directions_walk,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
