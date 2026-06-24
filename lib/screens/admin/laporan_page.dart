import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme.dart';
import '../../widgets/custom_card.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Library Statistics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Borrowing Trend',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                                if (value.toInt() < months.length) {
                                  return Text(months[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        spots: [
                          const FlSpot(0, 3),
                          const FlSpot(1, 4),
                          const FlSpot(2, 5),
                          const FlSpot(3, 4.5),
                          const FlSpot(4, 6),
                          const FlSpot(5, 7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Category Statistics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Books by Category',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: AppColors.primary,
                            value: 40,
                            title: 'Fiction',
                            radius: 80,
                          ),
                          PieChartSectionData(
                            color: AppColors.secondary,
                            value: 30,
                            title: 'Science',
                            radius: 80,
                          ),
                          PieChartSectionData(
                            color: AppColors.accent,
                            value: 20,
                            title: 'History',
                            radius: 80,
                          ),
                          PieChartSectionData(
                            color: AppColors.info,
                            value: 10,
                            title: 'Other',
                            radius: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            CustomCard(
              child: Column(
                children: [
                  _buildSummaryRow('Total Books', '245'),
                  Divider(color: AppColors.border),
                  _buildSummaryRow('Books Borrowed', '56'),
                  Divider(color: AppColors.border),
                  _buildSummaryRow('Overdue Books', '12'),
                  Divider(color: AppColors.border),
                  _buildSummaryRow('Active Students', '342'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}