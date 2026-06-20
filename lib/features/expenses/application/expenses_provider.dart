import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/expense.dart';

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super(_seed());

  static List<Expense> _seed() => [
        Expense(id: '1', amount: 320, category: 'أكل', note: 'خبز وحليب', date: DateTime.now()),
        Expense(id: '2', amount: 400, category: 'نقل', note: 'طاكسي', date: DateTime.now()),
        Expense(id: '3', amount: 1500, category: 'فواتير', note: 'إنترنت', date: DateTime.now().subtract(const Duration(days: 1))),
      ];

  void add(Expense e) => state = [e, ...state];
  void remove(String id) => state = state.where((e) => e.id != id).toList();
  double get todayTotal => state
      .where((e) => _sameDay(e.date, DateTime.now()))
      .fold(0, (s, e) => s + e.amount);
  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

final expensesProvider =
    StateNotifierProvider<ExpensesNotifier, List<Expense>>((ref) => ExpensesNotifier());
