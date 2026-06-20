# LifeDz — مركز حياتك اليومي

> تطبيق هاتف ذكي يساعد الأفراد والعائلات في الجزائر على تنظيم المصاريف، التذكيرات، المشتريات، ومهام العائلة في تجربة واحدة سريعة وجميلة.

## ما هذا المجلد؟
هذا هو **الهيكل الكامل لمشروع LifeDz** (النسخة الأولى / MVP). يحتوي على:

- تطبيق **Flutter** كامل البنية (Android + iOS) بوحدات مستقلة.
- مخطط قاعدة بيانات **Supabase / PostgreSQL** كامل مع سياسات الأمان (RLS).
- **نظام تصميم** (ألوان، خطوط، مسافات، مكوّنات).
- **وثائق** الرؤية والمعمارية وخارطة الطريق.

## كيف تشغّل المشروع (خطوة بخطوة)
أنت لست مضطراً لفهم الكود. أعطِ هذا المجلد لأي مطوّر Flutter وسيفهمه فوراً. للتشغيل:

```bash
# 1) تثبيت Flutter أولاً: https://docs.flutter.dev/get-started/install
flutter --version

# 2) توليد ملفات المنصات (android/ios) داخل المجلد
flutter create . --org dz.life --project-name lifedz

# 3) جلب الحزم
flutter pub get

# 4) إنشاء ملف البيئة (انسخ .env.example إلى .env واملأ بيانات Supabase)
cp .env.example .env

# 5) التشغيل
flutter run
```

## إعداد Supabase
1. أنشئ مشروعاً مجانياً على https://supabase.com
2. افتح SQL Editor والصق محتوى `supabase/schema.sql` ثم نفّذه.
3. انسخ `Project URL` و `anon key` إلى ملف `.env`.

## بنية المشروع
```
lib/
  core/        # الثيم، الثوابت، التوجيه، عميل Supabase
  features/    # الوحدات المستقلة
    auth/
    home/
    expenses/
    reminders/
    shopping/
    family/
    settings/
    insights/
  shared/      # مكوّنات وأدوات مشتركة
supabase/      # مخطط قاعدة البيانات
docs/          # الوثائق
```

## الترخيص
ملكية خاصة — LifeDz © 2026.
