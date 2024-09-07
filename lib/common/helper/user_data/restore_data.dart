import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<String?> getToken() async {
  return await storage.read(key: 'auth_token');
}
