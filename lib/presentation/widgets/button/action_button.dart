import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? heigth;
  final double? fontSize;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final bool
  isLoading; // nota: corregí la ortografía a isLoading sería más estándar
  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 300.0,
    this.heigth = 30,
    this.fontSize = 13,
    this.minWidth = 200.0,
    this.maxWidth = 350.0,
    this.minHeight = 20.0,
    this.maxHeight = 50.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
          maxWidth: maxWidth ?? double.infinity,
          minHeight: minHeight ?? 0,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          onPressed: isLoading
              ? null
              : onPressed, // deshabilitado si está cargando
          child: Container(
            width: width,
            alignment: Alignment.center,
            height: heigth,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
