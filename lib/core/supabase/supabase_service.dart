import 'package:supabase_flutter/supabase_flutter.dart';

/// Thin wrapper around the Supabase client.
class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  SupabaseClient get client => Supabase.instance.client;
  GoTrueClient get auth => Supabase.instance.client.auth;

  User? get currentUser => auth.currentUser;
  bool get isSignedIn => currentUser != null;
}
