import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class HomeAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final String bothValue;
  final Function(String)? onSelected;

  const HomeAppBar({
    super.key,
    required this.bothValue,
    this.onSelected,
  });

  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorName.colorUbicacion,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: const Icon(Icons.location_on_rounded),
          ),
           Text(widget.bothValue, style: TextStyle(fontSize: 17),),
        ],
      ),
    );
  }
}
