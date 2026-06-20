import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class ShoppingItem {
  ShoppingItem(this.name, this.category, {this.bought = false});
  final String name;
  final String category;
  bool bought;
}

final shoppingProvider = StateProvider<List<ShoppingItem>>((ref) => [
      ShoppingItem('حليب', 'بقالة'),
      ShoppingItem('خبز', 'بقالة'),
      ShoppingItem('زيت', 'بقالة', bought: true),
      ShoppingItem('طماطم', 'خضر وفواكه'),
    ]);

class ShoppingScreen extends ConsumerWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(shoppingProvider);
    final remaining = items.where((e) => !e.bought).length;
    return Scaffold(
      appBar: AppBar(title: const Text('المشتريات')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('إضافة عنصر'),
        onPressed: () => _add(context, ref),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Text('بقي $remaining عنصراً لم يُشتَرَ بعد',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: AppSpacing.md),
          ...List.generate(items.length, (i) {
            final item = items[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: CheckboxListTile(
                value: item.bought,
                activeColor: AppColors.primary,
                title: Text(
                  item.name,
                  style: TextStyle(
                    decoration: item.bought ? TextDecoration.lineThrough : null,
                    color: item.bought ? AppColors.textMuted : null,
                  ),
                ),
                subtitle: Text(item.category),
                onChanged: (v) {
                  final list = [...ref.read(shoppingProvider)];
                  list[i].bought = v ?? false;
                  ref.read(shoppingProvider.notifier).state = list;
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  void _add(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('إضافة عنصر', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'اسم العنصر')),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                if (ctrl.text.trim().isNotEmpty) {
                  ref.read(shoppingProvider.notifier).state = [
                    ...ref.read(shoppingProvider),
                    ShoppingItem(ctrl.text.trim(), 'أخرى'),
                  ];
                }
                Navigator.pop(ctx);
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }
}
