import 'package:flutter/material.dart';
import '../config/theme.dart';

class DigitalClockWidget extends StatelessWidget {
  final dynamic clock;
  final bool is24HourFormat;
  final double fontSize;

  const DigitalClockWidget({
    Key? key,
    required this.clock,
    required this.is24HourFormat,
    this.fontSize = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            is24HourFormat ? clock.formattedTime : _format12Hour(clock),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              fontFamily: 'Courier',
              letterSpacing: 2,
            ),
          ),
          if (!is24HourFormat) ...[const SizedBox(width: 12)],
          if (!is24HourFormat)
            Text(
              clock.period,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  String _format12Hour(dynamic clock) {
    final hour = int.parse(clock.hour12);
    final minute = clock.minute;
    final second = clock.second;
    return '$hour:$minute:$second';
  }
}