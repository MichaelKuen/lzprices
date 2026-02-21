import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PermissionsService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream of current user's permissions map with all relevant keys
  Stream<Map<String, dynamic>> get permissionsStream {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return _defaultPermissions();

      final data = snapshot.data()!;
      final permissions = Map<String, dynamic>.from(data['permissions'] ?? {});

      // Ensure all keys exist with default values if missing
      return {
        'canEdit': permissions['canEdit'] ?? false,
        'canDelete': permissions['canDelete'] ?? false,
        'showPrice': permissions['showPrice'] ?? true,
        'showInstallerPrice': permissions['showInstallerPrice'] ?? true,
        'showWholesalePrice': permissions['showWholesalePrice'] ?? true,
      };
    });
  }

  /// Default permissions map for new users or missing permissions
  Map<String, dynamic> _defaultPermissions() {
    return {
      'canEdit': false,
      'canDelete': false,
      'showPrice': true,
      'showInstallerPrice': true,
      'showWholesalePrice': true,
    };
  }

  /// Optional helper to update a single permission
  Future<void> updatePermission(String key, bool value) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set(
      {
        'permissions': {key: value}
      },
      SetOptions(merge: true), // merge so we don't overwrite other permissions
    );
  }
}