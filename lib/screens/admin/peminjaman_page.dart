import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/borrowing_provider.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_button.dart';

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({Key? key}) : super(key: key);

  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  @override
  void initState() {
    super.initState();
    context.read<BorrowingProvider>().loadAllBorrowings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowing Records'),
      ),
      body: Consumer<BorrowingProvider>(
        builder: (context, borrowingProvider, _) {
          if (borrowingProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (borrowingProvider.borrowings.isEmpty) {
            return const Center(child: Text('No borrowing records'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: borrowingProvider.borrowings.length,
            itemBuilder: (context, index) {
              final borrowing = borrowingProvider.borrowings[index];
              final isOverdue = borrowing.isOverdue;
              return CustomCard(
                backgroundColor: isOverdue ? AppColors.error.withOpacity(0.05) : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Buku ID: ${borrowing.bukuId.substring(0, 8)}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: borrowing.status == 'returned'
                                ? AppColors.success.withOpacity(0.1)
                                : isOverdue
                                    ? AppColors.error.withOpacity(0.1)
                                    : AppColors.info.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            borrowing.status == 'returned'
                                ? 'Returned'
                                : isOverdue
                                    ? 'Overdue'
                                    : 'Active',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: borrowing.status == 'returned'
                                  ? AppColors.success
                                  : isOverdue
                                      ? AppColors.error
                                      : AppColors.info,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Borrowed: ${borrowing.tanggalPinjam.toString().split(' ')[0]}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Due: ${borrowing.tanggalKembaliTarget.toString().split(' ')[0]}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (borrowing.denda > 0) ...[const SizedBox(height: 8)],
                    if (borrowing.denda > 0)
                      Text(
                        'Fine: Rp ${borrowing.denda}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (borrowing.status == 'active') ...[const SizedBox(height: 12)],
                    if (borrowing.status == 'active')
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'Return Book',
                          onPressed: () {
                            context.read<BorrowingProvider>().returnBook(borrowing.id);
                          },
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
}