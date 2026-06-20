import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

/// Bottom-navigation shell hosting the 5 primary tabs.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  static const _tabs = [
    _Tab('/home', Icons.home_rounded, 'الرئيسية'),
    _Tab('/expenses', Icons.account_balance_wallet_rounded, 'المصاريف'),
    _Tab('/reminders', Icons.notifications_rounded, 'التذكيرات'),
    _Tab('/shopping', Icons.shopping_cart_rounded, 'المشتريات'),
    _Tab('/family', Icons.groups_rounded, 'العائلة'),
  ];

  int _indexFor(String location) {
    final i = _tabs.indexWhere((t) => location.startsWith(t.path));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final current = _indexFor(location);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current,
        onTap: (i) => context.go(_tabs[i].path),
        selectedItemColor: AppColors.primary,
        items: [
          for (final t in _tabs)
            BottomNavigationBarItem(icon: Icon(t.icon), label: t.label),
        ],
      ),
    );
  }
}

class _Tab {
  const _Tab(this.path, this.icon, this.label);
  final String path;
  final IconData icon;
  final String label;
}
