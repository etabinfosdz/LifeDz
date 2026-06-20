import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_R>[
      _R(Icons.medication_rounded, AppColors.catHealth, 'دواء الوالد', 'اليوم ٨:٠٠ مساءً', 'دواء'),
      _R(Icons.receipt_long_rounded, AppColors.catBills, 'فاتورة الإنترنت', 'بعد يومين', 'فاتورة'),
      _R(Icons.local_hospital_rounded, AppColors.accent, 'موعد طبي', 'الثلاثاء ١٠:٣٠', 'موعد'),
      _R(Icons.school_rounded, AppColors.catKids, 'دفع رسوم المدرسة', 'نهاية الأسبوع', 'مهمة'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('التذكيرات')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('تذكير جديد'),
        onPressed: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text('الكل')),
              Chip(label: Text('أدوية')),
              Chip(label: Text('فواتير')),
              Chip(label: Text('مواعيد')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...items.map((r) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: r.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(r.icon, color: r.color),
                  ),
                  title: Text(r.title),
                  subtitle: Text(r.when),
                  trailing: Chip(
                    label: Text(r.tag, style: const TextStyle(fontSize: 11)),
                    padding: EdgeInsets.zero,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _R {
  _R(this.icon, this.color, this.title, this.when, this.tag);
  final IconData icon; final Color color; final String title; final String when; final String tag;
}
