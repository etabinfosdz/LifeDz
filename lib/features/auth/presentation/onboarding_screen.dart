import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                ),
                child: const Icon(Icons.bolt_rounded, size: 52, color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('LifeDz', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'مركز حياتك اليومي — المصاريف، التذكيرات، المشتريات، والعائلة في مكان واحد.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => context.go('/sign-in'),
                  child: const Text('ابدأ الآن'),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => context.go('/home'),
                child: const Text('تجربة بدون حساب'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
