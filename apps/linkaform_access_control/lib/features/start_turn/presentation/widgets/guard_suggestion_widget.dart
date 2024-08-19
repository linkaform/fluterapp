import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/features/start_turn/domain/entities/load_shift_entity.dart';
import 'package:ui_look_and_feel_module/gen/colors.gen.dart';

import 'package:linkaform_access_control/features/start_turn/presentation/providers/start_turn_providers.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/widgets/button_action_widget.dart';

class GuardSuggestionWidget extends ConsumerStatefulWidget {
  const GuardSuggestionWidget({super.key});

  @override
  ConsumerState createState() => _GuardSuggestionWidgetState();
}

class _GuardSuggestionWidgetState extends ConsumerState<GuardSuggestionWidget> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.security),
              Text(
                'Guardias de Apoyo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ButtonActionWidget(
              label: 'Seleccionar',
              butttonColor: ColorName.colorConfirmNew,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const GuardListModal(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GuardListModal extends ConsumerStatefulWidget {
  const GuardListModal({super.key});

  @override
  ConsumerState createState() => _GuardListModalState();
}

class _GuardListModalState extends ConsumerState<GuardListModal> {
  @override
  Widget build(BuildContext context) {
    final availableGuards =
        ref.watch(startTurnProvider).supportGuards;

    return AlertDialog(
      title: const Text('Guardias de Apoyo'),
      content: SingleChildScrollView(
        // Wrap the content in a SingleChildScrollView
        child: Column(
          children: availableGuards
                  ?.map(
                    (guard) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(guard?.picture?.fileUrl ?? ''),
                      ),
                      title: Text(guard?.name ?? ''),
                      subtitle: Text(guard.status ?? ''),
                      trailing: Checkbox(
                        value: guard.isSelected,
                        onChanged: (value) {
                          ref.read(startTurnProvider.notifier).selectGuard(
                                chosenGuard: guard,
                                isSelected: value,
                              );
                        },
                      ),
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
      actions: [],
    );
  }
}
