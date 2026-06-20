import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../application/expenses_provider.dart';
import '../domain/expense.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  static const categories = ['أكل', 'نقل', 'منزل', 'صحة', 'أطفال', 'فواتير', 'تسوق', 'أخرى'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    final notifier = ref.read(expensesProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('المصاريف')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('إضافة مصروف'),
        onPressed: () => _showAdd(context, notifier),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Column(
              children: [
                const Text('مصروف اليوم', style: TextStyle(color: AppColors.primaryDark)),
                const SizedBox(height: 4),
                Text('${notifier.todayTotal.toStringAsFixed(0)} د.ج',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...expenses.map((e) => _tile(context, ref, e)),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, WidgetRef ref, Expense e) => Dismissible(
        key: ValueKey(e.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          color: AppColors.danger.withValues(alpha: 0.1),
          child: const Icon(Icons.delete, color: AppColors.danger),
        ),
        onDismissed: (_) => ref.read(expensesProvider.notifier).remove(e.id),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.surfaceAlt,
            child: const Icon(Icons.payments_rounded, color: AppColors.primary),
          ),
          title: Text(e.category),
          subtitle: e.note != null ? Text(e.note!) : null,
          trailing: Text('${e.amount.toStringAsFixed(0)} د.ج',
              style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
      );

  void _showAdd(BuildContext context, ExpensesNotifier notifier) {
    final amountCtrl = TextEditingController();
    String category = categories.first;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: StatefulBuilder(
          builder: (ctx, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('إضافة مصروف', style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'المبلغ (د.ج)'),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  for (final c in categories)
                    ChoiceChip(
                      label: Text(c),
                      selected: category == c,
                      onSelected: (_) => setState(() => category = c),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text) ?? 0;
                  if (amount > 0) {
                    notifier.add(Expense(
                      id: const Uuid().v4(),
                      amount: amount,
                      category: category,
                      date: DateTime.now(),
                    ));
                  }
                  Navigator.pop(ctx);
                },
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
