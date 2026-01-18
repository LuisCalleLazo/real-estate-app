import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;

  const CustomInput({
    super.key,
    required this.label,
    this.icon,
    this.placeholder,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8, left: 4),
              child: Text(label, style: Theme.of(context).textTheme.labelLarge),
            ),
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              maxLines: obscureText ? 1 : maxLines,
              minLines: minLines,
              validator: validator,
              onChanged: onChanged,
              enabled: enabled,
              textCapitalization: textCapitalization,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: placeholder,
                prefixIcon: icon != null
                    ? Icon(icon, size: isSmallScreen ? 20 : 24)
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12 : 16,
                  vertical: isSmallScreen ? 12 : 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
