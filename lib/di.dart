import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AppInit {
  static init() async {
    await GetStorage.init();
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.get("SUPABASE_URL"),
      anonKey: dotenv.get("SUPABASE_ANON_KEY"),
      authFlowType: AuthFlowType.pkce,
    );
  }
}
