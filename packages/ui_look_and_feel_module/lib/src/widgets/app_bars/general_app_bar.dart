import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:ui_look_and_feel_module/gen/colors.gen.dart';

class GeneralAppBar {

  static PreferredSizeWidget build({
    String? title,
    List<Widget>? actions,
    bool centerTitle = true,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? titleColor,
    Color? iconColor,
    Icon? leading,
  }) => AppBar(
    title: Text(title ?? ''),
    actions: actions,
    centerTitle: centerTitle,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    leading: leading,
    iconTheme: IconThemeData(color: iconColor),
  );
}
