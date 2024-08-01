import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class HomeAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final String defaultValue;
  final List<String> dropdownList;
  final Function(String)? onSelected;

  const HomeAppBar({
    super.key,
    required this.defaultValue,
    required this.dropdownList,
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
                value: widget.defaultValue,
                items: widget.dropdownList.map<DropdownMenuItem<String>>((String value) {
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
                onChanged: (selectedValue) => widget.onSelected != null ? widget.onSelected!(selectedValue ?? '') : null ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
