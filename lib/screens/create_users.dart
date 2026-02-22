import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUsersScreen extends StatefulWidget {
  const CreateUsersScreen({super.key});

  @override
  State<CreateUsersScreen> createState() => _CreateUsersScreenState();
}

class _CreateUsersScreenState extends State<CreateUsersScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isAdmin = false;
  bool _loading = true;
  bool _creatingUser = false;

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

    setState(() {
      _isAdmin = doc.data()?['isAdmin'] ?? false;
      _loading = false;
    });
  }

  Future<void> _createUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Email and password required');
      return;
    }

    if (password.length < 6) {
      _showMessage('Password must be at least 6 characters');
      return;
    }

    setState(() => _creatingUser = true);

    try {
      final adminUser = _auth.currentUser;

      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        "email": email,
        "isAdmin": false,
        "permissions": {
          "canEdit": false,
          "canDelete": false,
          "showPrice": true,
          "showInstallerPrice": true,
          "showWholesalePrice": false,
          "accessStartTime": "09:00",
          "accessEndTime": "17:00",
          "accessDays": {
            "monday": true,
            "tuesday": true,
            "wednesday": true,
            "thursday": true,
            "friday": true,
            "saturday": false,
            "sunday": false,
          }
        }
      });

      _emailController.clear();
      _passwordController.clear();

      _showMessage("User created successfully");

      // IMPORTANT: sign admin back in (Firebase switches to new user automatically)
      if (adminUser != null) {
        await _auth.signOut();
      }

    } catch (e) {
      _showMessage("Error creating user: $e");
    } finally {
      setState(() => _creatingUser = false);
    }
  }

  void _showMessage(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
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
          child: Text(
            'You do not have permission to access this page',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _creatingUser
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('Create User'),
                onPressed: _createUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}