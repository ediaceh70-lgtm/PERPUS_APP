import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/timezone_clock.dart';
import '../../providers/timezone_provider.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/digital_clock_widget.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    // Update clocks every second
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        context.read<TimeZoneProvider>().updateAllClocks();
      }
    });

    _setupTimer();
  }

  void _setupTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.read<TimeZoneProvider>().updateAllClocks();
        _setupTimer();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Clock'),
        elevation: 0,
        actions: [
          Consumer<TimeZoneProvider>(
            builder: (context, timeZoneProvider, _) {
              return IconButton(
                icon: Icon(
                  timeZoneProvider.is24HourFormat ? Icons.access_time : Icons.schedule,
                ),
                onPressed: () {
                  timeZoneProvider.toggleTimeFormat();
                },
                tooltip: timeZoneProvider.is24HourFormat ? '24-Hour Format' : '12-Hour Format',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTimeZoneDialog(context),
          ),
        ],
      ),
      body: Consumer<TimeZoneProvider>(
        builder: (context, timeZoneProvider, _) {
          return timeZoneProvider.clocks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 64,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No time zones added',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to add a time zone',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: timeZoneProvider.clocks.length,
                  itemBuilder: (context, index) {
                    final clock = timeZoneProvider.clocks[index];
                    return CustomCard(
                      onTap: () => _showClockDetails(context, clock, index),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    clock.timeZone.name,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    clock.timeZone.timezone,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  context.read<TimeZoneProvider>().removeClock(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Time zone removed'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DigitalClockWidget(
                            clock: clock,
                            is24HourFormat: timeZoneProvider.is24HourFormat,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            clock.formattedDate,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  void _showAddTimeZoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Time Zone'),
        content: SizedBox(
          width: double.maxFinite,
          child: Consumer<TimeZoneProvider>(
            builder: (context, timeZoneProvider, _) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: timeZoneProvider.availableTimeZones.length,
                itemBuilder: (context, index) {
                  final tz = timeZoneProvider.availableTimeZones[index];
                  final isAdded = timeZoneProvider.clocks
                      .any((c) => c.timeZone.timezone == tz.timezone);
                  return ListTile(
                    title: Text(tz.name),
                    subtitle: Text(tz.timezone),
                    trailing: isAdded ? const Icon(Icons.check) : null,
                    enabled: !isAdded,
                    onTap: isAdded
                        ? null
                        : () {
                            context.read<TimeZoneProvider>().addClock(tz);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${tz.name} added'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showClockDetails(BuildContext context, clock, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              clock.timeZone.name,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              clock.timeZone.timezone,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  DigitalClockWidget(
                    clock: clock,
                    is24HourFormat: context.read<TimeZoneProvider>().is24HourFormat,
                    fontSize: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    clock.formattedDate,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}