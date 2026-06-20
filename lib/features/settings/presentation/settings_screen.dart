import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('المزيد')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const ListTile(leading: Icon(Icons.person_rounded), title: Text('الملف الشخصي')),
          const ListTile(leading: Icon(Icons.groups_rounded), title: Text('العائلة')),
          const ListTile(leading: Icon(Icons.bar_chart_rounded), title: Text('الإحصائيات')),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_rounded),
            title: const Text('الوضع الليلي'),
            value: mode == ThemeMode.dark,
            onChanged: (v) => ref.read(themeControllerProvider.notifier)
                .setMode(v ? ThemeMode.dark : ThemeMode.light),
          ),
          const ListTile(leading: Icon(Icons.help_outline_rounded), title: Text('الدعم')),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('تسجيل الخروج'),
            onTap: () => context.go('/onboarding'),
          ),
        ],
      ),
    );
  }
}
