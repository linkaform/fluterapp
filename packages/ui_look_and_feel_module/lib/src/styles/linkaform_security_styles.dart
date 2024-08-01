import 'package:flutter/material.dart';
import 'package:ui_look_and_feel_module/gen/colors.gen.dart';
import 'package:ui_look_and_feel_module/src/providers/form_validator_providers.dart';

class LinkaformSecurityStyles {
  static InputDecoration TextFormFieldStyle(
    String label,
    FieldType type, {
    bool? isPasswordVisible,
    Function()? method,
  }) =>
      InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorName.colorHideText,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorName.colorHideText,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
        suffixIcon: type == FieldType.Password
            ? IconButton(
                icon: Icon(
                  isPasswordVisible == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: method,
              )
            : null,
      );

  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    fixedSize: Size(250.0, 50.0),
    backgroundColor: ColorName.colorChangeOther,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  static final ButtonStyle textHoveredButtonStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all<Color>(ColorName.colorBody),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) => states.contains(WidgetState.pressed)
          ? ColorName.colorChangeOther.withOpacity(0.12)
          : null,
    ),
  );
}
