import 'package:flutter/material.dart';
import 'package:mind_track/app/theme/app_colors.dart';

/// Paleta semántica dependiente del brillo actual. Mapea los colores fijos
/// del diseño de Figma (modo claro) a sus equivalentes del tema oscuro.
class MTColors {
  const MTColors._(this.isDark);

  final bool isDark;

  /// Fondo de tarjetas (blanco en claro).
  Color get card => isDark ? AppColors.darkCard : Colors.white;

  /// Superficie ligeramente distinta al fondo (headers, inputs suaves).
  Color get surfaceSubtle =>
      isDark ? AppColors.darkSurface : const Color(0xFFF8FAFC);

  /// Borde estándar (#E2E8F0 en claro).
  Color get border => isDark ? AppColors.darkBorder : const Color(0xFFE2E8F0);

  /// Borde muy sutil (#F1F5F9 en claro). También se usa como relleno gris.
  Color get borderSubtle =>
      isDark ? AppColors.darkBorder : const Color(0xFFF1F5F9);

  /// Texto principal (#0F172A / #1E293B en claro).
  Color get textPrimary =>
      isDark ? AppColors.darkTextPrimary : const Color(0xFF0F172A);

  /// Texto secundario (#64748B / #475569 en claro).
  Color get textSecondary =>
      isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B);

  /// Texto atenuado (#94A3B8 en claro).
  Color get textMuted =>
      isDark ? const Color(0xFF7C8AA0) : const Color(0xFF94A3B8);

  /// Relleno de pistas de progreso y controles segmentados (#F1F5F9).
  Color get trackFill =>
      isDark ? AppColors.darkBorder : const Color(0xFFF1F5F9);

  /// Chip/checkbox sin seleccionar (#CBD5E1 / #D1D5DB en claro).
  Color get controlBorder =>
      isDark ? const Color(0xFF3B4A61) : const Color(0xFFCBD5E1);
}

extension MTColorsX on BuildContext {
  MTColors get mtColors =>
      MTColors._(Theme.of(this).brightness == Brightness.dark);
}
