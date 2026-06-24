import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 50,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ahmad Hidayat',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              'Student',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Information',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Email', 'ahmad@school.com'),
                  _buildInfoRow('Class', 'X-A'),
                  _buildInfoRow('Phone', '081234567890'),
                  _buildInfoRow('Joined', 'June 2026'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Library Statistics',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Books Borrowed', '12'),
                  _buildInfoRow('Books Returned', '9'),
                  _buildInfoRow('Overdue Books', '0'),
                  _buildInfoRow('Total Fines', 'Rp 0'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Edit Profile',
              onPressed: () {},
              width: double.infinity,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Logout',
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              width: double.infinity,
              isOutlined: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}