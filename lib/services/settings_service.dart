import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String adminUsersKey = 'admin_users';
  static const String retailPriceUsersKey = 'retail_price_users';
  static const String installerPriceUsersKey = 'installer_price_users';
  static const String wholesalePriceUsersKey = 'wholesale_price_users';

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList(adminUsersKey) == null) {
      await prefs.setStringList(adminUsersKey, ['michaelkuen888@gmail.com']);
    }
  }

  Future<List<String>> getUsersForRole(String roleKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(roleKey) ?? [];
  }

  Future<void> addUserToRole(String email, String roleKey) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsersForRole(roleKey);
    if (!users.contains(email.toLowerCase())) {
      users.add(email.toLowerCase());
      await prefs.setStringList(roleKey, users);
    }
  }

  Future<void> removeUserFromRole(String email, String roleKey) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsersForRole(roleKey);
    if (users.contains(email.toLowerCase())) {
      users.remove(email.toLowerCase());
      await prefs.setStringList(roleKey, users);
    }
  }

  Future<bool> isUserAdmin(String email) async {
    final admins = await getUsersForRole(adminUsersKey);
    return admins.contains(email.toLowerCase());
  }
}
