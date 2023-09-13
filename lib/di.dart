import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AppInit {
  static init() async {
    await GetStorage.init();
    await Supabase.initialize(
      url: "https://rraktjcfcqgvywujwomi.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJyYWt0amNmY3Fndnl3dWp3b21pIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ2NDEwMjYsImV4cCI6MjAxMDIxNzAyNn0.bVy2zsLUNFDgnqaqIEvzem1kaiifIJcR9-YntDmD7Gg",
      authFlowType: AuthFlowType.pkce,
    );
  }
}
