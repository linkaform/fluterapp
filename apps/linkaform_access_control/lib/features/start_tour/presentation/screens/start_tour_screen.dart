import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/core/utils/data_extensions.dart';
import 'package:linkaform_access_control/features/home/presentation/providers/home_providers.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class StartTourScreen extends ConsumerWidget {
  const StartTourScreen({super.key});

  static const String imageUrl =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
  static const String path = '/start-tour';
  static const String name = 'start-tour';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guardHouse = ref.watch(guardHouseValueProvider);
    final guardHouseSelected = ref.watch(guardHouseSelectedValueProvider);
    final guardHouseList = ref.watch(guardHouseListProvider);
    var guarHouseTemp = guardHouseSelected;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles de Turno',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: CachedImageWidget(imageUrl: imageUrl),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Manuel Silva Cruz',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text('Jefe de Seguridad'),
                            Text('manuelSilva@gmail.com'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoSection(
                    'Información de Ingreso', Icons.calendar_month_rounded, [
                  _buildInfoRow('Fecha:', 'Lunes 25 de Junio del 2024'),
                  _buildInfoRow('Hora:', '18:35:02 hrs'),
                  _buildInfoRow('Estatus:', 'Turno Cerrado'),
                ]),
                const SizedBox(height: 20),
                _buildInfoSection(
                  'Información Sobre la Ubicación',
                  Icons.location_on_rounded,
                  [
                    _buildInfoRow('Ubicación:', 'Planta Monterrey'),
                    _buildInfoRow('Ciudad:', 'Monterrey'),
                    _buildInfoRow('Estado:', 'Nuevo León'),
                    _buildInfoRow('Dirección:', 'Calzada Madero S/N'),
                    _buildInfoRow(
                      'Caseta:',
                      guardHouseSelected?.split('-').last ??
                          guardHouse.split('-').last,
                    ),
                  ],
                  button: _buildActionItem(
                    context,
                    ref,
                    'Cambiar Caseta',
                    'Cambiar Caseta',
                    'Selecciona una Caseta',
                    guardHouseList,
                    guardHouseSelected != guardHouse,
                    ColorName.colorChangeOther,
                    'Caseta no disponible',
                    'Esta seguro que desea iniciar turno en la ${guardHouseSelected}?',
                    'La caseta seleccionada no esta disponible, por favor seleccione otra caseta.',
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoSection(
                  'Información Sobre la Caseta',
                  Icons.maps_home_work_rounded,
                  [
                    _buildInfoRow('Estatus de la Caseta:', 'No Disponible'),
                    _buildInfoRow(
                        'Guardia en Turno:', 'Jacinto Martínez Sánchez'),
                    _buildInfoRow('Fecha y Hora de Inicio de Turno:',
                        '25 de Junio del 2024 16:01 hrs'),
                  ],
                  button: _buildActionItem(
                    context,
                    ref,
                    'Forzar cierre',
                    'Forzar cierre de caseta',
                    '¿Está seguro que desea forzar el cierre de la caseta? \tEsta acción no se puede deshacer.',
                    List<String>.empty(),
                    true,
                    ColorName.colorDeleteStandOutIncidentes,
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.note_alt_rounded,
                        size: 18,
                      ),
                    ),
                    Text(
                      'Notas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                _buildNoteItem(
                  'Juan Carlos Rodríguez Martínez',
                  'Revisar paquetería y estatus de vehículos en la caseta 6'
                      .limitLength(26),
                ),
                const SizedBox(height: 20),
                _buildStatGrid(),
                const SizedBox(height: 20),
                _buildGuardiasSugerencias(context, ref),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: ColorName.colorVisitas,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) => Dialog(
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text(
                              'Nueva Nota',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                                decoration: noteStyle('Titulo de la nota')),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: TextFormField(
                              decoration:
                                  noteStyle('Cualquier información adicional'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fotografía de la evidencia',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.add_photo_alternate_sharp,
                                  size: 130,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                                decoration:
                                    noteStyle('Documento de la evidencia')),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                  onPressed: () => context.pop(),
                                  child: Text('Cancelar')),
                              OutlinedButton(
                                  onPressed: () {}, child: Text('Agregar')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              child: const Column(
                children: [
                  Icon(Icons.note_add),
                  Text('Nueva Nota'),
                ],
              ),
            ),
            const Column(
              children: [
                Icon(Icons.home),
                Text('Menú'),
              ],
            ),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Confirmacion'),
                        content: IntrinsicHeight(
                          child: Column(
                            children: [
                              Text(
                                'Esta seguro que desea iniciar turno en la Caseta 6?',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  OutlinedButton(
                                      onPressed: () => context.pop(),
                                      child: Text('Cancelar')),
                                  OutlinedButton(
                                      onPressed: () => context.go(HomeScreen.path), child: Text('Agregar')),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

              ),
              child: const Column(children: [
                Icon(Icons.play_arrow),
                Text('Iniciar'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    String title,
    IconData icon,
    List<Widget> children, {
    Widget? button,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon, size: 18),
            ),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
            if (button != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: button,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
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
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String author, String content, [Color? noteColor]) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4), // Espacio entre items
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Color del contorno
          width: 1, // Ancho del contorno
        ),
        borderRadius: BorderRadius.circular(4), // Bordes redondeados (opcional)
      ),
      child: ListTile(
        title: Text(
          author,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        subtitle: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.circle,
                size: 13,
                color: noteColor ?? Colors.orange,
              ),
            ),
            Text(
              '$content ',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.remove_red_eye),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.check),
            ),
            Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatItem('Personal Dentro', '23', Icons.people),
        _buildStatItem('Equipos Concesionados', '13', Icons.build),
        _buildStatItem('Fallas Pendientes', '2', Icons.warning),
        _buildStatItem('Vehículos Estacionados', '18', Icons.directions_car),
        _buildStatItem('Gafetes Pendientes', '14', Icons.badge),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
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

  Widget _buildGuardiasSugerencias(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Guardias de Apoyo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildListActionItem(
              context,
              ref,
              'Agregar guardias',
              'Guardias',
              ref.watch(guardListProvider),
              ColorName.colorChangeOther,
            ),
          ],
        ),
        const Text('Sugerencias',
            style: TextStyle(fontWeight: FontWeight.bold)),
        _buildGuardiaItem('Fernando López García'),
        _buildGuardiaItem('Juan Carlos Rodríguez Martínez'),
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

  Widget _buildGuardiaItem(String name) {
    return ListTile(
      leading: const Icon(Icons.person_outline),
      title: Text(name),
      trailing: const Text('Disponible'),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    WidgetRef ref,
    String label,
    String dialogTitle,
    String dialogContent,
    List<String>? dialogDropDownItems,
    bool isValidDialog,
    Color backgroundColor, [
    String? invalidDialogTitle,
    String? invalidDialogContent,
    String? invalidDialogContentSubtitle,
  ]) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 40),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isValidDialog)
                      Column(
                        children: [
                          Text(
                            dialogTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            dialogContent,
                            textAlign: TextAlign.center,
                          ),
                          if (dialogDropDownItems != null) ...[
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dialogDropDownItems
                                  .map((e) => TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            EdgeInsets.zero,
                                          ),
                                        ),
                                        onPressed: () {
                                          ref
                                              .read(
                                                guardHouseSelectedValueProvider
                                                    .notifier,
                                              )
                                              .state = e;
                                          context.pop();
                                        },
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ],
                      )
                    else
                      Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 55,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            invalidDialogTitle ?? 'Error',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            invalidDialogContent ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          if (invalidDialogContentSubtitle != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              invalidDialogContentSubtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => context.pop(),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  /// Add this into a consumer stateful widget
  Widget _buildListActionItem(
    BuildContext context,
    WidgetRef ref,
    String label,
    String dialogTitle,
    List<String>? dialogDropDownItems,
    Color backgroundColor, [
    Size? size,
  ]) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(10, 35),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height *
                  (0.15 * (dialogDropDownItems?.length ?? 0.0)),
              minWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          dialogTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (dialogDropDownItems != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dialogDropDownItems
                                  .map(
                                    (e) => ListTile(
                                      leading: const Icon(
                                        Icons.person_outline,
                                      ),
                                      title: Text(
                                        e.limitLength(20),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      trailing: Checkbox(
                                        value: ref
                                                .watch(
                                                    guardSelectedValueProvider
                                                        .notifier)
                                                .state ==
                                            e,
                                        onChanged: (value) {
                                          ref
                                              .watch(
                                                guardSelectedValueProvider
                                                    .notifier,
                                              )
                                              .state = value! ? e : null;
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  InputDecoration noteStyle(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorName.colorHideText,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorName.colorHideText,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
      );
}
