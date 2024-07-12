import 'package:flutter/material.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorName.colorUbicacion,
      title: Row(
        children: [
          const Icon(Icons.location_on_rounded),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: ColorName.colorBody,
                  size: 24,
                ),
                value: 'Planta Monterrey - Caseta 6 Poniente',
                items: <String>[
                  'Planta Monterrey - Caseta 6 Poniente',
                  'Otra Ubicación',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: ColorName.colorBody,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
