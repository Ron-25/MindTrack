import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/analytics/domain/entities/analytics_snapshot.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_state.dart';
import 'package:mind_track/shared/pages/main_shell_page.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnalyticsCubit>(
      create: (_) => Injector.get<AnalyticsCubit>()..loadSnapshot(),
      child: _AnalyticsView(),
    );
  }
}

class _AnalyticsView extends StatefulWidget {
  _AnalyticsView();

  @override
  State<_AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<_AnalyticsView> {
  int _selectedRange = 0;

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MindTrackAppBar(title: translations.analytics_title),
      body: SafeArea(
        child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
          builder: (BuildContext context, AnalyticsState state) {
            if (state.isLoading && state.snapshot == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null && state.snapshot == null) {
              return _ErrorState(
                message: state.errorMessage!,
                onRetry: context.read<AnalyticsCubit>().loadSnapshot,
              );
            }

            final AnalyticsSnapshot snapshot = state.snapshot!;
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: context.read<AnalyticsCubit>().loadSnapshot,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16, 24, 16, 32),
                children: <Widget>[
                  _buildRangeSelector(translations),
                  SizedBox(height: 32),
                  _TrendsSection(
                    summary: snapshot.weeklySummary,
                    points: snapshot.correlation,
                  ),
                  SizedBox(height: 32),
                  _DistributionSection(frequency: snapshot.frequency),
                  SizedBox(height: 32),
                  _PatternsSection(
                    summary: snapshot.weeklySummary,
                    points: snapshot.correlation,
                  ),
                  SizedBox(height: 32),
                  _InsightCard(summary: snapshot.weeklySummary),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRangeSelector(S translations) {
    final List<String> labels = <String>[
      translations.analytics_range_week,
      translations.analytics_range_month,
      translations.analytics_range_year,
    ];
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: List<Widget>.generate(labels.length, (int index) {
          final bool isSelected = _selectedRange == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedRange = index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isSelected
                      ? <BoxShadow>[
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  labels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : context.mtColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TrendsSection extends StatelessWidget {
  const _TrendsSection({required this.summary, required this.points});

  final WeeklySummaryData summary;
  final List<HabitMoodPoint> points;

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    final _MoodSeries? series = _buildSeries();
    final bool isFallback = series?.isFallback ?? false;
    final Color moodColor = _colorFromHex(
      summary.dominantEmotionColorHex,
      AppColors.primary,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                translations.analytics_trends_title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.mtColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFD1FAE5),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                translations.analytics_records_count(summary.totalLogs),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF059669),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _FigmaCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                translations.analytics_mood_flow_label,
                style: TextStyle(
                  fontSize: 14,
                  color: context.mtColors.textSecondary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                summary.dominantEmotionName ??
                    translations.analytics_no_dominant_emotion,
                style: TextStyle(
                  fontSize: 30,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: context.mtColors.textPrimary,
                ),
              ),
              SizedBox(height: 6),
              Text(
                isFallback
                    ? translations.analytics_mood_flow_fallback_caption
                    : translations.analytics_mood_flow_caption,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.35,
                  color: context.mtColors.textMuted,
                ),
              ),
              SizedBox(height: 24),
              if (series == null)
                SizedBox(
                  height: 152,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      translations.analytics_correlation_empty,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: context.mtColors.textSecondary),
                    ),
                  ),
                )
              else ...<Widget>[
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _MoodLinePainter(
                      values: series.values,
                      maxY: series.maxY,
                      color: moodColor,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.only(
                    left: _MoodLinePainter.axisWidth,
                    right: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: points.map((HabitMoodPoint point) {
                      final bool isToday = _isSameDay(
                        point.date,
                        DateTime.now(),
                      );
                      return Text(
                        _dayLetter(context, point.date),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isToday
                              ? AppColors.primary
                              : context.mtColors.textMuted,
                        ),
                      );
                    }).toList(growable: false),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Construye la serie a graficar: intensidades diarias (con huecos en los
  /// días sin registros) o, si no hay intensidades, hábitos completados.
  _MoodSeries? _buildSeries() {
    if (points.length < 2) {
      return null;
    }
    final List<double?> intensities = points
        .map(
          (HabitMoodPoint point) => (point.avgIntensity ?? 0) > 0
              ? point.avgIntensity
              : null,
        )
        .toList(growable: false);
    if (intensities.whereType<double>().length >= 2) {
      return _MoodSeries(values: intensities, maxY: 10, isFallback: false);
    }

    // Si no hay intensidades registradas, usa los habitos completados.
    final List<double?> habits = points
        .map<double?>((HabitMoodPoint point) => point.habitsCompleted.toDouble())
        .toList(growable: false);
    if (habits.every((double? value) => value == 0)) {
      return null;
    }
    final double maxHabits = habits.whereType<double>().reduce(math.max);
    return _MoodSeries(
      values: habits,
      maxY: math.max(maxHabits, 4),
      isFallback: true,
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _dayLetter(BuildContext context, DateTime date) {
    final String locale = Localizations.localeOf(context).languageCode;
    final String letter = DateFormat.E(locale).format(date);
    return letter.substring(0, 1).toUpperCase();
  }
}

class _DistributionSection extends StatelessWidget {
  const _DistributionSection({required this.frequency});

  final List<EmotionFrequencyItem> frequency;

  static const List<Color> _fallbackPalette = <Color>[
    AppColors.primary,
    Color(0xFFFBBF24),
    Color(0xFFF87171),
    Color(0xFF34D399),
    Color(0xFFA78BFA),
  ];

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translations.analytics_distribution_title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.mtColors.textPrimary,
          ),
        ),
        SizedBox(height: 16),
        _FigmaCard(
          child: frequency.isEmpty
              ? Text(
                  translations.analytics_frequency_empty,
                  style: TextStyle(color: context.mtColors.textSecondary),
                )
              : _buildDistribution(context),
        ),
      ],
    );
  }

  Widget _buildDistribution(BuildContext context) {
    final List<EmotionFrequencyItem> items = frequency.take(5).toList();
    final List<Color> colors = List<Color>.generate(items.length, (int index) {
      return _colorFromHex(
        items[index].colorHex,
        _fallbackPalette[index % _fallbackPalette.length],
      );
    });
    final EmotionFrequencyItem top = items.reduce(
      (EmotionFrequencyItem a, EmotionFrequencyItem b) =>
          a.percentage >= b.percentage ? a : b,
    );

    return Row(
      children: <Widget>[
        SizedBox(
          width: 128,
          height: 128,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CustomPaint(
                painter: _DonutPainter(
                  percentages: items
                      .map((EmotionFrequencyItem item) => item.percentage)
                      .toList(growable: false),
                  colors: colors,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${top.percentage.round()}%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: context.mtColors.textPrimary,
                      ),
                    ),
                    Text(
                      top.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: context.mtColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 32),
        Expanded(
          child: Column(
            children: List<Widget>.generate(items.length, (int index) {
              final EmotionFrequencyItem item = items[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0 : 12,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors[index],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.mtColors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      '${item.percentage.round()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: context.mtColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

}

Color _colorFromHex(String? hex, Color fallback) {
  if (hex == null || hex.isEmpty) {
    return fallback;
  }
  final String normalized = hex.replaceFirst('#', '');
  if (normalized.length != 6) {
    return fallback;
  }
  return Color(int.parse('FF$normalized', radix: 16));
}

class _PatternsSection extends StatelessWidget {
  const _PatternsSection({required this.summary, required this.points});

  final WeeklySummaryData summary;
  final List<HabitMoodPoint> points;

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translations.analytics_patterns_title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.mtColors.textPrimary,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 130,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _PatternCard(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  borderColor: AppColors.primary.withValues(alpha: 0.2),
                  icon: Icons.wb_sunny_outlined,
                  iconColor: AppColors.primary,
                  label: translations.analytics_top_day_label,
                  value: _topDayText(context, translations),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _PatternCard(
                  backgroundColor: Color(0xFFFEF3C7),
                  borderColor: Color(0x80FDE68A),
                  icon: Icons.nightlight_round,
                  iconColor: Color(0xFFD97706),
                  label: translations.analytics_habits_card_label,
                  value: summary.habitsCompletionPct != null
                      ? translations.analytics_habits_card_value(
                          summary.habitsCompletionPct!.round(),
                        )
                      : translations.analytics_no_data_short,
                  onTap: () {
                    final MainShellPageState? shell = MainShellPage.of(context);
                    if (shell != null) {
                      shell.goToTab(MainShellPage.habitsTab);
                      return;
                    }
                    Navigator.of(context).pushNamed(RouteNames.habits);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _topDayText(BuildContext context, S translations) {
    HabitMoodPoint? best;
    for (final HabitMoodPoint point in points) {
      final double intensity = point.avgIntensity ?? 0;
      if (intensity > 0 && (best == null || intensity > (best.avgIntensity ?? 0))) {
        best = point;
      }
    }
    if (best == null) {
      return translations.analytics_no_data_short;
    }
    final String locale = Localizations.localeOf(context).languageCode;
    final String day = DateFormat.EEEE(locale).format(best.date);
    return translations.analytics_top_day_value(day);
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.onTap,
  });

  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 22, color: iconColor),
              SizedBox(height: 10),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6,
                  color: context.mtColors.textSecondary,
                ),
              ),
              SizedBox(height: 2),
              Expanded(
                child: Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                    color: context.mtColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.summary});

  final WeeklySummaryData summary;

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    final String insight = summary.insightText?.trim().isNotEmpty == true
        ? summary.insightText!
        : translations.analytics_default_insight;
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.mtColors.textPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              Text(
                translations.analytics_insight_title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            insight,
            style: TextStyle(
              fontSize: 14,
              height: 1.625,
              color: context.mtColors.controlBorder,
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(RouteNames.coach),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    translations.analytics_read_more,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FigmaCard extends StatelessWidget {
  const _FigmaCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.mtColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.05)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _MoodSeries {
  const _MoodSeries({
    required this.values,
    required this.maxY,
    required this.isFallback,
  });

  /// Un valor por día; `null` significa que ese día no hay registros.
  final List<double?> values;
  final double maxY;
  final bool isFallback;
}

class _MoodLinePainter extends CustomPainter {
  _MoodLinePainter({
    required this.values,
    required this.maxY,
    required this.color,
  });

  final List<double?> values;
  final double maxY;
  final Color color;

  /// Espacio reservado a la izquierda para las etiquetas del eje.
  static const double axisWidth = 26;
  static const double _topPadding = 22;
  static const double _bottomPadding = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final int count = values.length;
    final double chartWidth = size.width - axisWidth;
    final double chartHeight = size.height - _topPadding - _bottomPadding;
    if (count < 2 || chartWidth <= 0 || chartHeight <= 0) {
      return;
    }

    double yFor(double value) {
      final double normalized = (value / maxY).clamp(0.0, 1.0);
      return _topPadding + (1 - normalized) * chartHeight;
    }

    double xFor(int index) => axisWidth + chartWidth * index / (count - 1);

    // Líneas de referencia con su valor (0, mitad y máximo de la escala).
    final Paint gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1;
    for (final double gridValue in <double>[0, maxY / 2, maxY]) {
      final double y = yFor(gridValue);
      canvas.drawLine(Offset(axisWidth, y), Offset(size.width, y), gridPaint);
      final TextPainter axisLabel = TextPainter(
        text: TextSpan(
          text: _formatValue(gridValue),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF94A3B8),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      axisLabel.paint(
        canvas,
        Offset(axisWidth - axisLabel.width - 6, y - axisLabel.height / 2),
      );
    }

    // Segmentos continuos entre días con datos; los días sin registro
    // quedan como huecos en la línea.
    final List<List<int>> segments = <List<int>>[];
    List<int> currentSegment = <int>[];
    for (int i = 0; i < count; i++) {
      if (values[i] != null) {
        currentSegment.add(i);
      } else if (currentSegment.isNotEmpty) {
        segments.add(currentSegment);
        currentSegment = <int>[];
      }
    }
    if (currentSegment.isNotEmpty) {
      segments.add(currentSegment);
    }

    final Paint linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Offset.zero & size);

    for (final List<int> segment in segments) {
      if (segment.length < 2) {
        continue;
      }
      final List<Offset> nodes = segment
          .map((int index) => Offset(xFor(index), yFor(values[index]!)))
          .toList(growable: false);
      final Path linePath = Path()..moveTo(nodes.first.dx, nodes.first.dy);
      for (int i = 0; i < nodes.length - 1; i++) {
        final double midX = (nodes[i].dx + nodes[i + 1].dx) / 2;
        linePath.cubicTo(
          midX,
          nodes[i].dy,
          midX,
          nodes[i + 1].dy,
          nodes[i + 1].dx,
          nodes[i + 1].dy,
        );
      }
      final Path fillPath = Path.from(linePath)
        ..lineTo(nodes.last.dx, yFor(0))
        ..lineTo(nodes.first.dx, yFor(0))
        ..close();
      canvas.drawPath(fillPath, fillPaint);
      canvas.drawPath(linePath, linePaint);
    }

    // Punto y valor de cada día con datos.
    int lastWithData = -1;
    for (int i = count - 1; i >= 0; i--) {
      if (values[i] != null) {
        lastWithData = i;
        break;
      }
    }
    final Paint dotFillPaint = Paint()..color = Colors.white;
    for (int i = 0; i < count; i++) {
      final double? value = values[i];
      if (value == null) {
        continue;
      }
      final Offset node = Offset(xFor(i), yFor(value));
      final bool isLast = i == lastWithData;
      final double radius = isLast ? 5 : 4;
      canvas.drawCircle(node, radius, dotFillPaint);
      canvas.drawCircle(
        node,
        radius,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = isLast ? 3 : 2,
      );

      final TextPainter valueLabel = TextPainter(
        text: TextSpan(
          text: _formatValue(value),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isLast ? color : const Color(0xFF475569),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final double labelX = (node.dx - valueLabel.width / 2).clamp(
        axisWidth,
        math.max(size.width - valueLabel.width, axisWidth),
      );
      final double labelY = math.max(
        node.dy - valueLabel.height - radius - 5,
        0,
      );
      valueLabel.paint(canvas, Offset(labelX, labelY));
    }
  }

  String _formatValue(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString();
    }
    return value.toStringAsFixed(1);
  }

  @override
  bool shouldRepaint(_MoodLinePainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.maxY != maxY ||
        oldDelegate.color != color;
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.percentages, required this.colors});

  final List<double> percentages;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 14;
    final Rect rect = const Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    final Paint trackPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, 0, math.pi * 2, false, trackPaint);

    final double total = percentages.fold(
      0,
      (double sum, double value) => sum + value,
    );
    if (total <= 0) {
      return;
    }

    double startAngle = -math.pi / 2;
    for (int i = 0; i < percentages.length; i++) {
      final double sweep = (percentages[i] / math.max(total, 100)) * math.pi * 2;
      if (sweep <= 0) {
        continue;
      }
      final Paint segmentPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawArc(rect, startAngle, sweep, false, segmentPaint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter oldDelegate) {
    return oldDelegate.percentages != percentages ||
        oldDelegate.colors != colors;
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: Text(S.of(context).home_retry),
            ),
          ],
        ),
      ),
    );
  }
}
