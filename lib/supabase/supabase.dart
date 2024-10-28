import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize Supabase client
final supabase = Supabase.instance.client;

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: 'https://ugvcmfripsepimuwetav.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVndmNtZnJpcHNlcGltdXdldGF2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjYyODM4MTAsImV4cCI6MjA0MTg1OTgxMH0.jdOtxDcv6ZkDlNCQrzEhxaoyWaji4ThzBE65AG0bpqo',
  );
}
