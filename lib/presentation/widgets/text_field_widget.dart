import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../gen/colors.gen.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String? text)? validator;
  final Widget? suffix;
  final Widget? prefix;
  final Function()? onTab;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool enableFocusColor;
  final String? prefixText;
  final bool obscurePassword;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final FocusNode? focusNode;
  final Key? globalKey;
  final Function(String)? onChanged;
  const TextFieldWidget(
      {super.key,
      required this.controller,
      this.globalKey,
      this.validator,
      this.hintText,
      this.suffix,
      this.prefix,
      this.onTab,
      this.keyboardType,
      this.readOnly = false,
      this.prefixText,
      this.enableFocusColor = true,
      this.obscurePassword = false,
      this.inputFormatters,
      this.focusNode,
      this.onChanged,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: globalKey,
      focusNode: focusNode,
      onTap: onTab,
      onChanged: onChanged,
      obscureText: obscurePassword,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      readOnly: readOnly,
      cursorColor: ColorName.primaryColor,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Color(0xFF8E8E8E),
          fontWeight: FontWeight.w500,
        ),
        prefixText: prefixText != null ? '$prefixText ' : null,
        prefixIcon: prefix,
        suffixIcon: suffix,
        prefixStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: enableFocusColor
              ? const BorderSide(
                  color: ColorName.primaryColor,
                  width: 2,
                )
              : const BorderSide(),
        ),
      ),
    );
  }
}
