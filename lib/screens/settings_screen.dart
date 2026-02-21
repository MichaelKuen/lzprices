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

  Future<void> _checkAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc =
    await _firestore.collection('users').doc(user.uid).get();

    if (doc.exists) {
      setState(() {
        _isAdmin = doc['isAdmin'] ?? false;
        _loading = false;
      });
    }
  }

  Future<void> _updatePermission(
      String userId, String permissionKey, bool value) async {
    await _firestore.collection('users').doc(userId).update({
      'permissions.$permissionKey': value,
    });
  }

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

              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text(email),
                  children: permissions.keys.map((permissionKey) {
                    final bool currentValue =
                        permissions[permissionKey] ?? false;

                    return CheckboxListTile(
                      title: Text(permissionKey),
                      value: currentValue,
                      onChanged: (value) {
                        _updatePermission(
                          userDoc.id,
                          permissionKey,
                          value!,
                        );
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