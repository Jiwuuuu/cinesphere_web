import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize Supabase client
final supabase = Supabase.instance.client;

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: '',
    anonKey: '',
  );
}
