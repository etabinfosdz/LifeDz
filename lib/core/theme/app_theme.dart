import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Builds the light & dark themes for LifeDz.
class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      textTheme: _textTheme(base.textTheme, AppColors.textPrimary, AppColors.textSecondary),
      cardTheme: _cardTheme(AppColors.surface, AppColors.border),
      appBarTheme: _appBarTheme(AppColors.background, AppColors.textPrimary),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      inputDecorationTheme: _inputTheme(AppColors.surfaceAlt, AppColors.border),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surfaceDark,
        error: AppColors.danger,
      ),
      textTheme: _textTheme(base.textTheme, AppColors.textPrimaryDark, AppColors.textSecondaryDark),
      cardTheme: _cardTheme(AppColors.surfaceDark, AppColors.borderDark),
      appBarTheme: _appBarTheme(AppColors.backgroundDark, AppColors.textPrimaryDark),
      inputDecorationTheme: _inputTheme(AppColors.surfaceAltDark, AppColors.borderDark),
    );
  }

  static TextTheme _textTheme(TextTheme base, Color primary, Color secondary) {
    return GoogleFonts.cairoTextTheme(base).copyWith(
      headlineLarge: GoogleFonts.cairo(fontSize: 26, fontWeight: FontWeight.w800, color: primary),
      headlineMedium: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w700, color: primary),
      titleLarge: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w700, color: primary),
      titleMedium: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
      bodyLarge: GoogleFonts.cairo(fontSize: 15, color: primary),
      bodyMedium: GoogleFonts.cairo(fontSize: 14, color: secondary),
      labelLarge: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: primary),
    );
  }

  static CardThemeData _cardTheme(Color surface, Color border) {
    return CardThemeData(
      color: surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        side: BorderSide(color: border),
      ),
    );
  }

  static AppBarTheme _appBarTheme(Color bg, Color fg) {
    return AppBarTheme(
      backgroundColor: bg,
      foregroundColor: fg,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    );
  }

  static InputDecorationTheme _inputTheme(Color fill, Color border) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
      ),
    );
  }
}
