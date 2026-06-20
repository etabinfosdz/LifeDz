import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/quick_action_button.dart';
import '../../../shared/widgets/section_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('مساء الخير تيتوس 👋', style: t.headlineMedium),
                      Text('اليوم السبت — إليك ملخص يومك', style: t.bodyMedium),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primarySoft,
                  child: IconButton(
                    icon: const Icon(Icons.settings_rounded, color: AppColors.primary),
                    onPressed: () => context.go('/settings'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            // Smart daily summary
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('ملخص اليوم الذكي',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _summaryLine('لديك ٣ تذكيرات اليوم، أقربها دواء الوالد المساء'),
                  _summaryLine('مصروفك اليوم ٧٢٠ د.ج — أقل من المعتاد'),
                  _summaryLine('بقي عنصران في قائمة المشتريات'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Quick actions
            SectionCard(
              title: 'إجراءات سريعة',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuickActionButton(
                    icon: Icons.add_card_rounded,
                    label: 'مصروف',
                    color: AppColors.catFood,
                    onTap: () => context.go('/expenses'),
                  ),
                  QuickActionButton(
                    icon: Icons.alarm_add_rounded,
                    label: 'تذكير',
                    color: AppColors.accent,
                    onTap: () => context.go('/reminders'),
                  ),
                  QuickActionButton(
                    icon: Icons.add_shopping_cart_rounded,
                    label: 'شراء',
                    color: AppColors.catShopping,
                    onTap: () => context.go('/shopping'),
                  ),
                  QuickActionButton(
                    icon: Icons.task_alt_rounded,
                    label: 'مهمة',
                    color: AppColors.primary,
                    onTap: () => context.go('/family'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionCard(
              title: 'التذكيرات القادمة',
              trailing: TextButton(onPressed: () => context.go('/reminders'), child: const Text('الكل')),
              child: Column(
                children: [
                  _miniRow(Icons.medication_rounded, AppColors.catHealth, 'دواء الوالد', 'اليوم ٨:٠٠ مساءً'),
                  _miniRow(Icons.receipt_long_rounded, AppColors.catBills, 'فاتورة الإنترنت', 'بعد يومين'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionCard(
              title: 'لمحة عن المصاريف',
              trailing: TextButton(onPressed: () => context.go('/expenses'), child: const Text('التفاصيل')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _stat('اليوم', '٧٢٠ د.ج'),
                  _stat('الأسبوع', '٤٩٠٠ د.ج'),
                  _stat('الشهر', '٢١٣٠٠ د.ج'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryLine(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Icon(Icons.circle, size: 6, color: Colors.white70),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
          ],
        ),
      );

  Widget _miniRow(IconData icon, Color color, String title, String subtitle) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title)),
            Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      );

  Widget _stat(String label, String value) => Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        ],
      );
}
