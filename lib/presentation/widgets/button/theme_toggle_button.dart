import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return IconButton(
          icon: Icon(
            themeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () => themeNotifier.toggleTheme(),
          tooltip: themeNotifier.isDarkMode ? 'Modo claro' : 'Modo oscuro',
        );
      },
    );
  }
}

class ThemeToggleListTile extends StatelessWidget {
  const ThemeToggleListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return ListTile(
          leading: Icon(
            themeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
          title: Text(themeNotifier.isDarkMode ? 'Modo claro' : 'Modo oscuro'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () => themeNotifier.toggleTheme(),
        );
      },
    );
  }
}
