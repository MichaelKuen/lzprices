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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update permission: $e')),
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

              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text(email),
                  children: permissions.keys.map((permissionKey) {
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
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}