import 'dart:ui';

extension ThColorOpacity on Color {
  Color withOpacity1(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}
