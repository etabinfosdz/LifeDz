# المعمارية التقنية

## المكدّس التقني (Tech Stack)
- **الواجهة:** Flutter (Android + iOS بقاعدة كود واحدة)
- **إدارة الحالة:** Riverpod
- **التوجيه:** go_router
- **الخلفية:** Supabase + PostgreSQL
- **الإشعارات:** Firebase Cloud Messaging + flutter_local_notifications
- **التخزين المحلي (offline-first):** Hive

## مبدأ الوحدات المستقلة
كل ميزة = وحدة مستقلة (feature module) تحتوي على طبقات:
```
feature/
  domain/        # النماذج (models)
  application/   # المنطق والمزودات (providers)
  data/          # المستودعات (repositories - Supabase/Hive)
  presentation/  # الشاشات والمكوّنات
```
هذا يسمح بتحديثات يومية سريعة دون تخريب بقية التطبيق.

## الوحدات
- Auth · Home · Expenses · Reminders · Shopping · Family · Settings · Insights
