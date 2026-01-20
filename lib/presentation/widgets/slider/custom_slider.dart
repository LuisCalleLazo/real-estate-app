import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final String textStart;
  final String textEnd;
  final double initValue;
  final double endValue;
  final RangeValues valueRange;
  final void Function(RangeValues) onValueChange;
  const CustomSlider({
    super.key,
    this.textStart = 'Minimo',
    this.textEnd = 'Maximo',
    this.initValue = 0,
    this.endValue = 3000000,
    required this.valueRange,
    required this.onValueChange,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  RangeValues rangeValues = const RangeValues(0, 0);

  @override
  void initState() {
    super.initState();
    rangeValues = widget.valueRange;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.textEnd,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${rangeValues.start.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} BS',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.textEnd,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${rangeValues.end.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} BS',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        RangeSlider(
          values: rangeValues,
          min: widget.initValue,
          max: widget.endValue,
          divisions: 100,
          labels: RangeLabels(
            '${(rangeValues.start / 1000).toInt()}K',
            '${(rangeValues.end / 1000).toInt()}K',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              rangeValues = values;
            });
          },
          onChangeEnd: (RangeValues values) {
            widget.onValueChange(values);
          },
        ),
      ],
    );
  }
}
