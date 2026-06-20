import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/expenses/presentation/expenses_screen.dart';
import '../../features/reminders/presentation/reminders_screen.dart';
import '../../features/shopping/presentation/shopping_screen.dart';
import '../../features/family/presentation/family_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../shared/widgets/app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      // Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
          GoRoute(path: '/expenses', builder: (c, s) => const ExpensesScreen()),
          GoRoute(path: '/reminders', builder: (c, s) => const RemindersScreen()),
          GoRoute(path: '/shopping', builder: (c, s) => const ShoppingScreen()),
          GoRoute(path: '/family', builder: (c, s) => const FamilyScreen()),
          GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
        ],
      ),
    ],
  );
});
