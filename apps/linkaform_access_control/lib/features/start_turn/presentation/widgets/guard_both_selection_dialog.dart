import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/providers/home_providers.dart';
import 'package:linkaform_access_control/features/start_turn/domain/entities/booth_entity.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/providers/start_turn_providers.dart';

class ChangeGuardBoothDialog extends ConsumerWidget {
  const ChangeGuardBoothDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bothState = ref.watch(startTurnProvider);
    final guardHouseList = ref.watch(guardHouseListProvider);
    final selectedGuardHouse = ref.watch(guardHouseSelectedValueProvider);

    final uniqueGuardHouseMap = {
      for (var booth in guardHouseList)
        if (booth.location.isNotEmpty && booth.area.isNotEmpty)
          '${booth.location}-${booth.area}': booth
    };
    final uniqueGuardHouseList = uniqueGuardHouseMap.values.toList();

    return AlertDialog(
      title: const Text('Cambiar Caseta'),
      content: bothState.changeBothState == ChangeBothState.loading
          ? _buildLoadingIndicator(context)
          : _buildDialogContent(
          context, uniqueGuardHouseList, selectedGuardHouse, ref),
      actions: _buildDialogActions(context),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.21,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildDialogContent(
      BuildContext context,
      List<BoothData> guardHouseList,
      BoothData? selectedGuardHouse,
      WidgetRef ref,
      ) {
    final selectedValue = selectedGuardHouse != null &&
        selectedGuardHouse.location.isNotEmpty &&
        selectedGuardHouse.area.isNotEmpty
        ? '${selectedGuardHouse.location}-${selectedGuardHouse.area}'
        : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text('Selecciona una caseta:', style: TextStyle(fontSize: 16)),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              items: guardHouseList
                  .where((booth) =>
              booth.location.isNotEmpty && booth.area.isNotEmpty)
                  .map((booth) {
                return DropdownMenuItem<String>(
                  value: '${booth.location}-${booth.area}',
                  child: Text(
                    '${booth.location} - ${booth.area}',
                    style: const TextStyle(fontSize: 11),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  final selectedBooth = guardHouseList.firstWhere(
                        (booth) => '${booth.location}-${booth.area}' == value,
                    orElse: BoothData.empty,
                  );

                  if (selectedBooth.status == 'No Disponible') {
                    ref.read(guardHouseSelectedValueProvider.notifier).state =
                        selectedBooth;
                    context.pop();
                    _showUnavailableBoothDialog(context, selectedBooth);

                  } else {
                    ref.read(guardHouseSelectedValueProvider.notifier).state =
                        selectedBooth;
                    ref.read(startTurnProvider.notifier).changeBothState(
                      changeBothState: ChangeBothState.loaded,
                    );
                  }
                }
              },
              value: selectedValue,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDialogActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => context.pop(),
        child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
      ),
      TextButton(
        onPressed: () => context.pop(),
        child: const Text('Aceptar'),
      ),
    ];
  }

  void _showUnavailableBoothDialog(BuildContext context, BoothData booth) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Caseta no disponible'),
        content: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
                  fontSize: 16.0,
            ),
            children: [
              const TextSpan(text: 'La caseta '),
              TextSpan(
                text: '${booth.location} ${booth.area}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ' no está disponible. Seleccione otra caseta o fuerce el cierre para continuar.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}