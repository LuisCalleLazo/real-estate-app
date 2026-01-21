import 'package:flutter/material.dart';

class ZoneMapLabel extends StatelessWidget {
  final String name;
  const ZoneMapLabel({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    );
  }
}
