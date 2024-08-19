import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/core/utils/data_extensions.dart';
import 'package:linkaform_access_control/features/home/presentation/providers/home_providers.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/providers/start_turn_providers.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/button_action_widget.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/guard_both_selection_dialog.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/guard_presentation_card.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/guard_suggestion_widget.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/info_row_widget.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/info_section_widget.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/note_section_widget.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/start_tour_nav_bar.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/status_grid_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class StartTurnScreen extends ConsumerStatefulWidget {
  const StartTurnScreen({super.key});

  static const String path = '/start-tour';
  static const String name = 'start-tour';

  @override
  ConsumerState createState() => _StartTurnScreenState();
}

class _StartTurnScreenState extends ConsumerState<StartTurnScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(startTurnProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadShiftState = ref.watch(startTurnProvider).loadShiftState;
    final loadShiftData = ref.watch(startTurnProvider).loadShiftEntity?.data;
    final selectedGuardHouse = ref.watch(guardHouseSelectedValueProvider);

    return Scaffold(
      appBar: GeneralAppBar.build(
        title: loadShiftData?.guard?.status == 'in'
            ? 'Finalizar Turno'
            : 'Inicio de Turno',
        backgroundColor: ColorName.colorVisitas,
      ),
      body: SafeArea(
        child: loadShiftState == LoadShiftState.loading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: turnInfoContent(),
              )
            : turnInfoContent(),
      ),
      bottomNavigationBar: const StartTourNavBar(),
    );
  }

  Widget turnInfoContent() {
    final loadShiftState = ref.watch(startTurnProvider).loadShiftEntity?.data;
    final guardHouseSelected = ref.watch(guardHouseSelectedValueProvider);

    return SingleChildScrollView(
      primary: false,
      controller: ScrollController(),
      child: Column(
        children: [
          GuardHolderPresentationCard(
            guardHolderName: loadShiftState?.guard?.name ?? 'N/D',
            guardHolderPosition:
                loadShiftState?.guard?.checkinPosition ?? 'N/D',
            imageUrl: loadShiftState?.guard?.picture?.fileUrl ??
                GuardHolderPresentationCard.mockUrl,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoSectionWidget(
                  title: 'Información de Ingreso',
                  icon: Icons.calendar_month_rounded,
                  children: [
                    InfoRowWidget(
                      label: 'Fecha:',
                      value: DateTime.now().toString().toCustomDateFormat(),
                    ),
                    InfoRowWidget(
                      label: 'Hora:',
                      value: DateTime.now().toString().toCustomHourFormat(),
                    ),
                    InfoRowWidget(
                      label: 'Estatus:',
                      value: loadShiftState?.guard?.status == 'int'
                          ? 'En turno'
                          : 'Turno Cerrado',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InfoSectionWidget(
                    title: 'Información Sobre la Ubicación',
                    icon: Icons.location_on_rounded,
                    button: ButtonActionWidget(
                      label: 'Cambiar Caseta',
                      butttonColor: ColorName.colorConfirmNew,
                      onPressed: () {
                        ref.read(startTurnProvider.notifier).changeBoth();
                        showDialog(
                          context: context,
                          builder: (ctx) => const ChangeGuardBoothDialog(),
                        );
                      },
                    ),
                    children: [
                      InfoRowWidget(
                        label: 'Ubicación:',
                        value: loadShiftState?.guard?.location ?? '',
                      ),
                      InfoRowWidget(
                        label: 'Ciudad:',
                        value: loadShiftState?.location?.city ?? '',
                      ),
                      InfoRowWidget(
                        label: 'Estado:',
                        value: loadShiftState?.location?.state ?? '',
                      ),
                      InfoRowWidget(
                        label: 'Dirección:',
                        value: loadShiftState?.location?.address ?? '',
                      ),
                      InfoRowWidget(
                        label: 'Caseta:',
                        value: guardHouseSelected?.area ?? '',
                      ),
                    ],
                  ),
                ),
                InfoSectionWidget(
                  title: 'Información Sobre la Caseta',
                  icon: Icons.maps_home_work_rounded,
                  button: ButtonActionWidget(
                    label: 'Forzar cierre',
                    butttonColor: ColorName.colorDeleteStandOutIncidentes,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Forzar Cierre de Caseta'),
                          content: const Text(
                            '¿Estás seguro de forzar el cierre de la caseta?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(startTurnProvider.notifier)
                                    .forceCloseBooth();
                                context.pop();
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  children: [
                    InfoRowWidget(
                      label: 'Estatus:',
                      value: loadShiftState?.boothStatus?.status ?? '',
                      customStyle: TextStyle(
                        color:
                            loadShiftState?.boothStatus?.status == 'Disponible'
                                ? ColorName.colorEstatusGreen
                                : ColorName.colorEstatusRed,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InfoRowWidget(
                      label: 'Guardia en Turno:',
                      value: loadShiftState?.boothStatus?.guardOnDutty ?? '',
                    ),
                    InfoRowWidget(
                      label: 'Fecha y Hora de Inicio de Turno:',
                      value: loadShiftState?.boothStatus?.statedAt ?? '',
                    ),
                  ],
                ),
                const NoteSectionWidget(),
                const StatusGridWidget(),
                const GuardSuggestionWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
