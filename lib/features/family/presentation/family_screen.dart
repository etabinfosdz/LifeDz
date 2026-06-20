import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      ('شراء الخبز', 'أحمد', false),
      ('تنظيف المطبخ', 'سارة', false),
      ('دفع فاتورة الكهرباء', 'أنت', true),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('العائلة والمهام')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('مهمة جديدة'),
        onPressed: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('أفراد العائلة', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 84,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _member('أنت', AppColors.primary),
                _member('أحمد', AppColors.accent),
                _member('سارة', AppColors.catKids),
                _member('الوالد', AppColors.catHealth),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('مهام اليوم', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          ...tasks.map((t) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    t.$3 ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    color: t.$3 ? AppColors.success : AppColors.textMuted,
                  ),
                  title: Text(t.$1,
                      style: TextStyle(decoration: t.$3 ? TextDecoration.lineThrough : null)),
                  subtitle: Text('المسؤول: ${t.$2}'),
                ),
              )),
        ],
      ),
    );
  }

  Widget _member(String name, Color color) => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          children: [
            CircleAvatar(radius: 26, backgroundColor: color.withValues(alpha: 0.15),
                child: Text(name.characters.first, style: TextStyle(color: color, fontWeight: FontWeight.bold))),
            const SizedBox(height: 6),
            Text(name, style: const TextStyle(fontSize: 12)),
          ],
        ),
      );
}
