import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService();
  final Map<String, GlobalKey<FormState>> _formKeys = {
    SettingsService.adminUsersKey: GlobalKey<FormState>(),
    SettingsService.retailPriceUsersKey: GlobalKey<FormState>(),
    SettingsService.installerPriceUsersKey: GlobalKey<FormState>(),
    SettingsService.wholesalePriceUsersKey: GlobalKey<FormState>(),
  };
  final Map<String, TextEditingController> _controllers = {
    SettingsService.adminUsersKey: TextEditingController(),
    SettingsService.retailPriceUsersKey: TextEditingController(),
    SettingsService.installerPriceUsersKey: TextEditingController(),
    SettingsService.wholesalePriceUsersKey: TextEditingController(),
  };

  Map<String, List<String>> _roleUsers = {
    SettingsService.adminUsersKey: [],
    SettingsService.retailPriceUsersKey: [],
    SettingsService.installerPriceUsersKey: [],
    SettingsService.wholesalePriceUsersKey: [],
  };

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _loadUsers() async {
    final adminUsers = await _settingsService.getUsersForRole(SettingsService.adminUsersKey);
    final retailUsers = await _settingsService.getUsersForRole(SettingsService.retailPriceUsersKey);
    final installerUsers = await _settingsService.getUsersForRole(SettingsService.installerPriceUsersKey);
    final wholesaleUsers = await _settingsService.getUsersForRole(SettingsService.wholesalePriceUsersKey);
    setState(() {
      _roleUsers[SettingsService.adminUsersKey] = adminUsers;
      _roleUsers[SettingsService.retailPriceUsersKey] = retailUsers;
      _roleUsers[SettingsService.installerPriceUsersKey] = installerUsers;
      _roleUsers[SettingsService.wholesalePriceUsersKey] = wholesaleUsers;
    });
  }

  Future<void> _addUser(String roleKey) async {
    if (_formKeys[roleKey]!.currentState!.validate()) {
      final email = _controllers[roleKey]!.text;
      await _settingsService.addUserToRole(email, roleKey);
      _controllers[roleKey]!.clear();
      await _loadUsers();
    }
  }

  Future<void> _removeUser(String email, String roleKey) async {
    await _settingsService.removeUserFromRole(email, roleKey);
    await _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildRoleSection(
              context,
              title: 'Admins',
              roleKey: SettingsService.adminUsersKey,
            ),
            const SizedBox(height: 24),
            _buildRoleSection(
              context,
              title: 'Retail Price Users',
              roleKey: SettingsService.retailPriceUsersKey,
            ),
            const SizedBox(height: 24),
            _buildRoleSection(
              context,
              title: 'Installer Price Users',
              roleKey: SettingsService.installerPriceUsersKey,
            ),
            const SizedBox(height: 24),
            _buildRoleSection(
              context,
              title: 'Wholesale Price Users',
              roleKey: SettingsService.wholesalePriceUsersKey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSection(BuildContext context, {required String title, required String roleKey}) {
    final users = _roleUsers[roleKey] ?? [];
    return Form(
      key: _formKeys[roleKey],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controllers[roleKey],
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addUser(roleKey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...users.map((email) => ListTile(
            title: Text(email),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeUser(email, roleKey),
            ),
          )),
        ],
      ),
    );
  }
}
