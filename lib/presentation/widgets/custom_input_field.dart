import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool showError;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.focusNode,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: showError ? validator : null,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: showError
                ? Theme.of(context).inputDecorationTheme.errorBorder
                : Theme.of(context).inputDecorationTheme.border,
            focusedBorder: showError
                ? Theme.of(context).inputDecorationTheme.focusedErrorBorder
                : Theme.of(context).inputDecorationTheme.focusedBorder,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ),
        ),
        Positioned(
          bottom: -20,
          left: 16,
          child: showError
              ? SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    validator?.call(controller.text) ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
