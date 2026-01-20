// lib/config/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_app/config/theme/map_theme.dart';


class AppTheme {
  // Colores principales - Basados en la imagen (Naranja y Negro/Gris)
  static const Color primaryOrange = Color(0xFFF38118); // Naranja principal
  static const Color primaryOrangeDark = Color(0xFFD66F0D); // Naranja oscuro
  static const Color accentOrange = Color(0xFFFF8C42); // Naranja claro
  static const Color lightOrange = Color(0xFFFFE5D4); // Naranja muy claro

  // Backgrounds
  static const Color backgroundLight = Color(0xFFFAFAFA); // Gris muy claro
  static const Color backgroundDark = Color(0xFF1E191E); // Negro de la imagen
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF2C2C2C); // Gris oscuro

  // Texto
  static const Color textPrimary = Color(0xFF1E191E); // Negro
  static const Color textSecondary = Color(0xFF6B6B6B); // Gris
  static const Color textDark = Color(0xFFF2F2F2); // Blanco roto
  static const Color textSecondaryDark = Color(0xFFE5E5E5); // Gris claro

  // Estados
  static const Color success = Color(0xFF10B981); // Verde
  static const Color warning = Color(0xFFF59E0B); // Amarillo
  static const Color error = Color(0xFFEF4444); // Rojo

  // ===================== TEMA CLARO =====================
  ThemeData getLightTheme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary: primaryOrange,
      primaryContainer: lightOrange,
      secondary: accentOrange,
      surface: surfaceLight,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: backgroundLight,

    // AppBar
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: surfaceLight,
      foregroundColor: textPrimary,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    ),

    // Cards
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: surfaceLight,
    ),

    // Botones elevados
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Botones outlined
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: primaryOrange, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryOrange, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: GoogleFonts.inter(color: textSecondary, fontSize: 14),
    ),

    // Iconos
    iconTheme: const IconThemeData(color: primaryOrange, size: 24),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: lightOrange,
      labelStyle: GoogleFonts.inter(
        color: primaryOrangeDark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryOrange,
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryOrange,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // NavigationRail (para desktop)
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: surfaceLight,
      selectedIconTheme: const IconThemeData(color: primaryOrange, size: 24),
      unselectedIconTheme: const IconThemeData(color: textSecondary, size: 24),
      selectedLabelTextStyle: GoogleFonts.inter(
        color: primaryOrange,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      indicatorColor: primaryOrange.withValues(alpha: 0.1),
    ),

    // Typography
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textSecondary,
      ),
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade200,
      thickness: 1,
      space: 1,
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.sairaStencilOne(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.5,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(surfaceLight),
        elevation: WidgetStateProperty.all(4),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: surfaceLight,

      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      textStyle: GoogleFonts.sairaStencilOne(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.5,
      ),
    ),

    extensions: const <ThemeExtension<dynamic>>[
      MapThemeExtension(
        tileUrl: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        markerColor: primaryOrange,
        selectedMarkerColor: primaryOrangeDark,
        poiColor: Color(0xFFFFD700), // Dorado para POIs
      ),
    ],
  );

  // ===================== TEMA OSCURO =====================
  ThemeData getDarkTheme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary: primaryOrange,
      primaryContainer: primaryOrangeDark,
      secondary: accentOrange,
      surface: surfaceDark,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textDark,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: backgroundDark,

    // AppBar
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: backgroundDark,
      foregroundColor: textDark,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      iconTheme: const IconThemeData(color: textDark),
    ),

    // Cards
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      color: surfaceDark,
    ),

    // Botones elevados
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Botones outlined
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: primaryOrange, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryOrange, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: GoogleFonts.inter(color: textSecondaryDark, fontSize: 14),
    ),

    // Iconos
    iconTheme: const IconThemeData(color: primaryOrange, size: 24),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: primaryOrangeDark,
      labelStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryOrange,
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryOrange,
      unselectedItemColor: textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // NavigationRail (para desktop)
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: backgroundDark,
      selectedIconTheme: const IconThemeData(color: primaryOrange, size: 24),
      unselectedIconTheme: IconThemeData(color: textSecondaryDark, size: 24),
      selectedLabelTextStyle: GoogleFonts.inter(
        color: primaryOrange,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        color: textSecondaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      indicatorColor: primaryOrange.withValues(alpha: 0.2),
    ),

    // Typography
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textDark,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textDark,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textSecondaryDark,
      ),
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: Colors.white.withValues(alpha: 0.1),
      thickness: 1,
      space: 1,
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.sairaStencilOne(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textDark,
        letterSpacing: 0.5,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(surfaceDark),
        elevation: WidgetStateProperty.all(8),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
          ),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppTheme.surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      textStyle: GoogleFonts.sairaStencilOne(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppTheme.textDark,
        letterSpacing: 0.5,
      ),
    ),
    // Estilos para el mapa
    extensions: const <ThemeExtension<dynamic>>[
      MapThemeExtension(
        tileUrl: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
        markerColor: primaryOrange,
        selectedMarkerColor: accentOrange,
        poiColor: Color(0xFFFFD700),
      ),
    ],
  );
}
