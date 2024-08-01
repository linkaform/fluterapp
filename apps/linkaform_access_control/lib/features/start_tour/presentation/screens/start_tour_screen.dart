
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/core/utils/data_extensions.dart';
import 'package:linkaform_access_control/features/home/presentation/providers/home_providers.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/button_action_widget.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/guard_presentation_card.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/guard_suggestion_widget.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/info_row_widget.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/info_section_widget.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/note_section_widget.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/start_tour_nav_bar.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/widgets/status_grid_widget.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class StartTourScreen extends ConsumerWidget {
  const StartTourScreen({super.key});

  static const String path = '/start-tour';
  static const String name = 'start-tour';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guardHouse = ref.watch(guardHouseValueProvider);
    final guardHouseSelected = ref.watch(guardHouseSelectedValueProvider);


    return Scaffold(
      appBar: GeneralAppBar.build(
        title: 'Inicio de Turno',
        backgroundColor: ColorName.colorVisitas,
        iconColor: Colors.white,
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
                const GuardHolderPresentationCard(
                  guardHolderName: 'Alberto Cedillo',
                  guardHolderPosition: 'Jefe de seguridad',
                  guardHolderEmail: 'albertoc@gmail.com',
                ),
                const InfoSectionWidget(
                  title: 'Información de Ingreso',
                  icon: Icons.calendar_month_rounded,
                  children: [
                    InfoRowWidget(
                      label: 'Fecha:',
                      value: 'Lunes 25 de Junio del 2024',
                    ),
                    InfoRowWidget(
                      label: 'Hora:',
                      value: '18:35:02 hrs',
                    ),
                    InfoRowWidget(
                      label: 'Estatus:',
                      value: 'Turno Cerrado',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InfoSectionWidget(
                    title: 'Información Sobre la Ubicación',
                    icon: Icons.location_on_rounded,
                    button: const ButtonActionWidget(
                      label: 'Cambiar Caseta',
                      butttonColor: ColorName.colorChangeOther,
                    ),
                    children: [
                      const InfoRowWidget(
                        label: 'Ubicación:',
                        value: 'Planta Monterrey',
                      ),
                      const InfoRowWidget(
                        label: 'Ciudad:',
                        value: 'Monterrey',
                      ),
                      const InfoRowWidget(
                        label: 'Estado:',
                        value: 'Nuevo León',
                      ),
                      const InfoRowWidget(
                        label: 'Dirección:',
                        value: 'Calzada Madero S/N',
                      ),
                      InfoRowWidget(
                        label: 'Caseta:',
                        value: guardHouseSelected?.split('-').last ??
                            guardHouse.split('-').last,
                      ),
                    ],
                  ),
                ),
                const InfoSectionWidget(
                  title: 'Información Sobre la Caseta',
                  icon: Icons.maps_home_work_rounded,
                  button: ButtonActionWidget(
                    label: 'Forzar cierre',
                    butttonColor: ColorName.colorDeleteStandOutIncidentes,
                  ),
                  children: [
                    InfoRowWidget(
                      label: 'Estatus de la Caseta:',
                      value: 'No Disponible',
                    ),
                    InfoRowWidget(
                      label: 'Guardia en Turno:',
                      value: 'Jacinto Martínez Sánchez',
                    ),
                    InfoRowWidget(
                      label: 'Fecha y Hora de Inicio de Turno:',
                      value: '25 de Junio del 2024 16:01 hrs',
                    ),
                  ],
                ),
                NoteSectionWidget(
                  author: 'Juan Carlos Rodríguez Martínez',
                  content:
                      'Revisar paquetería y estatus de vehículos en la caseta 6'
                          .limitLength(26),
                  noteColor: ColorName.colorListFallas,
                ),
                const Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: StatusGridWidget(),
                ),
                const GuardSuggestionWidget(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const StartTourNavBar(),
    );
  }
}
