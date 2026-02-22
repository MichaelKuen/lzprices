import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isAdmin = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkAdmin();
  }

  /// Checks if the current user is an admin
  Future<void> _checkAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          _isAdmin = doc['isAdmin'] ?? false;
          _loading = false;
        });
      }
    } catch (e) {
      // Default to non-admin if error occurs
      setState(() {
        _isAdmin = false;
        _loading = false;
      });
    }
  }

  /// Updates a single permission inside the user's permissions map
  Future<void> _updatePermission(
      String userId, String permissionKey, bool value) async {
    try {
      await _firestore.collection('users').doc(userId).set(
        {
          'permissions': {permissionKey: value}
        },
        SetOptions(merge: true), // merge to avoid overwriting other permissions
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update permission: $e')),
      );
    }
  }

  /// Updates a user's access day permission
  Future<void> _updateAccessDay(String userId, String day, bool value) async {
    try {
      await _firestore.collection('users').doc(userId).set(
        {
          'permissions': {
            'accessDays': {day: value}
          }
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update access day: $e')),
      );
    }
  }

  /// Updates a user's access time
  Future<void> _updateAccessTime(
      String userId, String timeKey, String value) async {
    try {
      await _firestore.collection('users').doc(userId).set(
        {
          'permissions': {timeKey: value}
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update access time: $e')),
      );
    }
  }

  /// Default permissions keys to display for all users
  final List<String> _defaultPermissionKeys = [
    'canEdit',
    'canDelete',
    'showPrice',
    'showInstallerPrice',
    'showWholesalePrice',
  ];

  final List<String> _daysOfWeek = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isAdmin) {
      return const Scaffold(
        body: Center(
          child: Text('You do not have permission to access this page'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Permissions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').orderBy('email').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userDoc = users[index];
              final data = userDoc.data() as Map<String, dynamic>;
              final email = data['email'] ?? 'No email';
              final permissions =
              Map<String, dynamic>.from(data['permissions'] ?? {});

              // Ensure all default keys exist for display
              for (var key in _defaultPermissionKeys) {
                if (!permissions.containsKey(key)) {
                  permissions[key] = key == 'showPrice' ||
                      key == 'showInstallerPrice' ||
                      key == 'showWholesalePrice'
                      ? true
                      : false;
                }
              }

              final accessDays =
              Map<String, dynamic>.from(permissions['accessDays'] ?? {});
              final accessStartTime =
                  permissions['accessStartTime'] as String? ?? '09:00';
              final accessEndTime =
                  permissions['accessEndTime'] as String? ?? '17:00';

              List<Widget> childrenWidgets = [];

              // Add default permission checkboxes
              childrenWidgets.addAll(_defaultPermissionKeys.map((permissionKey) {
                final bool currentValue = permissions[permissionKey] ?? false;
                return CheckboxListTile(
                  title: Text(permissionKey),
                  value: currentValue,
                  onChanged: (value) {
                    if (value != null) {
                      _updatePermission(userDoc.id, permissionKey, value);
                    }
                  },
                );
              }));

              // Add dividers and day checkboxes
              childrenWidgets.add(const Divider());
              childrenWidgets.add(const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Access Days',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ));
              childrenWidgets.addAll(_daysOfWeek.map((day) {
                final bool currentValue = accessDays[day] ?? false;
                return CheckboxListTile(
                  title: Text(day[0].toUpperCase() + day.substring(1)),
                  value: currentValue,
                  onChanged: (value) {
                    if (value != null) {
                      _updateAccessDay(userDoc.id, day, value);
                    }
                  },
                );
              }));

              // Add dividers and allowed scheduled access time pickers
              childrenWidgets.add(const Divider());
              childrenWidgets.add(const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Allowed Scheduled Access',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ));
              childrenWidgets.add(const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Text(
                  'Set the allowed time window for this user to access the app.',
                  style: TextStyle(color: Colors.grey),
                ),
              ));

              childrenWidgets.add(ListTile(
                title: Text('Start Time: $accessStartTime'),
                trailing: const Icon(Icons.edit),
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: int.parse(accessStartTime.split(':')[0]),
                      minute: int.parse(accessStartTime.split(':')[1]),
                    ),
                  );
                  if (picked != null) {
                    final newTime =
                        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                    _updateAccessTime(userDoc.id, 'accessStartTime', newTime);
                  }
                },
              ));

              childrenWidgets.add(ListTile(
                title: Text('End Time: $accessEndTime'),
                trailing: const Icon(Icons.edit),
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: int.parse(accessEndTime.split(':')[0]),
                      minute: int.parse(accessEndTime.split(':')[1]),
                    ),
                  );
                  if (picked != null) {
                    final newTime =
                        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                    _updateAccessTime(userDoc.id, 'accessEndTime', newTime);
                  }
                },
              ));

              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text(email),
                  children: childrenWidgets,
                ),
              );
            },
          );
        },
      ),
    );
  }
}