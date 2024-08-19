import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/core/utils/data_extensions.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/providers/start_turn_providers.dart';

class NoteSectionWidget extends ConsumerStatefulWidget {
  const NoteSectionWidget({super.key});

  @override
  ConsumerState createState() => _NoteSectionWidgetState();
}

class _NoteSectionWidgetState extends ConsumerState<NoteSectionWidget> {
  @override
  Widget build(BuildContext context) {
    final notesData = ref
        .watch(startTurnProvider)
        .loadShiftEntity
        ?.data
        ?.notes;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
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
                'Notas', // TODO(text): translate it
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: notesData
                ?.map(
                  (note) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        note.createdByName ?? '',
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
                              color: note.noteStatus != 'abierto'
                                  ? Colors.orange
                                  : Colors.green,
                            ),
                          ),
                          Text(
                            note.noteOpenDate
                                .toString()
                                .toCustomStartDateFormat(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () =>
                            showDialog(
                              context: context,
                              builder: (ctx) =>
                                  AlertDialog(
                                    title: Row(
                                      children: [
                                        const Icon(Icons.note_alt_rounded),
                                        Text(note.id?.limitLength(15) ?? ''),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Estatus: ${note.noteStatus ??
                                              ''}'),
                                          Text('Fecha: ${note.noteOpenDate ??
                                              ''}'),
                                          Text(
                                              'Reporta: ${note.createdByName ??
                                                  ''}'),
                                          Text(note.note ?? ''),
                                          Text(
                                            'Comentarios: ${note.noteComments
                                                ?.firstOrNull?.commentData ??
                                                ''}',
                                          ),
                                          const SizedBox(height: 10),
                                          const Text('Fotografias:'),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: note.notePic
                                                ?.map(
                                                  (photo) =>
                                                  SizedBox(
                                                    width: 80,
                                                    height: 80,
                                                    child: Image.network(
                                                      photo.fileUrl ?? '',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                            )
                                                .toList() ??
                                                [],
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: const Text('Cerrar'),
                                      ),
                                    ],
                                  ),
                            ),
                        child: const Row(
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
                    ),
                  ),
            )
                .toList() ??
                [],
          ),
        ],
      ),
    );
  }
}
