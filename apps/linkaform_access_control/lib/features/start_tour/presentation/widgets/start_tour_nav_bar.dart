import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:ui_look_and_feel_module/ui_look_and_feel_module.dart';

class StartTourNavBar extends StatelessWidget {
  const StartTourNavBar({super.key});

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
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorName.colorHideText,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(2),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Container(
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
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
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
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
                                child: const Text('Cancelar')),
                            OutlinedButton(
                                onPressed: () {},
                                child: const Text('Agregar')),
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
                title: const Text('Confirmacion'),
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Text(
                        'Esta seguro que desea iniciar turno en la Caseta 6?',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                              onPressed: () => context.pop(),
                              child: const Text('Cancelar')),
                          OutlinedButton(
                              onPressed: () => context.go(HomeScreen.path),
                              child: const Text('Agregar')),
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
    );
  }
}
