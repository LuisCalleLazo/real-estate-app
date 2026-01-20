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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 4 : 8,
            vertical: isSmallScreen ? 4 : 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: isSmallScreen ? 6 : 8,
                  left: 4,
                ),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isDark
                        ? const Color(0xFFE5E5E5)
                        : const Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                style: TextStyle(
                  color: isDark
                      ? const Color(0xFFF2F2F2)
                      : const Color(0xFF1E191E),
                ),
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: TextStyle(
                    color: isDark
                        ? const Color(0xFF6B6B6B)
                        : const Color(0xFFAAAAAA),
                  ),
                  prefixIcon: icon != null
                      ? Icon(
                          icon,
                          size: isSmallScreen ? 20 : 24,
                          color: isDark
                              ? const Color(0xFFF38118)
                              : const Color(0xFFD66F0D),
                        )
                      : null,
                  filled: true,
                  fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                    borderSide: BorderSide(
                      color: isDark
                          ? const Color(0xFF3A3A3A)
                          : const Color(0xFFE0E0E0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                    borderSide: BorderSide(
                      color: isDark
                          ? const Color(0xFF3A3A3A)
                          : const Color(0xFFE0E0E0),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                    borderSide: BorderSide(
                      color: const Color(0xFFF38118),
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                    borderSide: const BorderSide(
                      color: Color(0xFFEF4444),
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                    borderSide: const BorderSide(
                      color: Color(0xFFEF4444),
                      width: 2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                    borderSide: BorderSide(
                      color: isDark
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFF0F0F0),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 14 : 18,
                    vertical: isSmallScreen ? 14 : 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
