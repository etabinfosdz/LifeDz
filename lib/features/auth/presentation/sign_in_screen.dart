import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          children: [
            const SizedBox(height: AppSpacing.lg),
            Text('أهلاً بك في LifeDz', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text('سجّل دخولك للبدء في تنظيم يومك.',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.xl),
            const TextField(decoration: InputDecoration(hintText: 'رقم الهاتف أو البريد')),
            const SizedBox(height: AppSpacing.md),
            const TextField(obscureText: true, decoration: InputDecoration(hintText: 'كلمة السر')),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => context.go('/home'),
              child: const Text('دخول'),
            ),
          ],
        ),
      ),
    );
  }
}
