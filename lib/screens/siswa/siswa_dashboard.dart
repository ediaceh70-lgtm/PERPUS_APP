import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_button.dart';

class SiswaDashboard extends StatefulWidget {
  const SiswaDashboard({Key? key}) : super(key: key);

  @override
  State<SiswaDashboard> createState() => _SiswaDashboardState();
}

class _SiswaDashboardState extends State<SiswaDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back, Ahmad!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Your library dashboard',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            // Quick Stats
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard('Books Borrowed', '3', Icons.library_books, AppColors.primary),
                _buildStatCard('Due Soon', '1', Icons.schedule, AppColors.warning),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'My Borrowing',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            // Current Borrowing
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Great Gatsby',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'F. Scott Fitzgerald',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Due: 2026-07-01', style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.warning.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Due in 3 days',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.info),
                        label: const Text('Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Browse Books',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'View All Books',
              onPressed: () {
                Navigator.of(context).pushNamed('/daftar_buku');
              },
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'My History',
              onPressed: () {
                Navigator.of(context).pushNamed('/riwayat_page');
              },
              width: double.infinity,
              isOutlined: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return CustomCard(
      backgroundColor: color.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}