import 'package:flutter/material.dart';

void sidePanel({
  required BuildContext context,
  required Widget content,
  required String label,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: label,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.centerRight,
        child: Material(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            ),
            child: content,
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      final slideAnimation = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return SlideTransition(position: slideAnimation, child: child);
    },
  );
}
