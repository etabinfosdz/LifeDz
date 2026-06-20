import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

/// A rounded card used across the app for grouped content.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.onTap,
    this.padding,
  });

  final Widget child;
  final String? title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(title!, style: Theme.of(context).textTheme.titleMedium),
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
