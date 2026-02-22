import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class PermissionsService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Map<String, dynamic>> get permissionsStream {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value({});
    }

    return _firestore.collection('users').doc(user.uid).snapshots().map((doc) {
      if (!doc.exists) {
        return {};
      }

      final data = doc.data() as Map<String, dynamic>;
      final permissions = Map<String, dynamic>.from(data['permissions'] ?? {});
      final isAdmin = data['isAdmin'] ?? false;

      // Add default permissions if they don't exist
      permissions.putIfAbsent('canEdit', () => false);
      permissions.putIfAbsent('canDelete', () => false);
      permissions.putIfAbsent('showPrice', () => true);
      permissions.putIfAbsent('showInstallerPrice', () => true);
      permissions.putIfAbsent('showWholesalePrice', () => true);

      // Add access control fields
      permissions.putIfAbsent('accessDays', () => {});
      permissions.putIfAbsent('accessStartTime', () => '00:00');
      permissions.putIfAbsent('accessEndTime', () => '23:59');

      // Add isAdmin to the map
      permissions['isAdmin'] = isAdmin;

      return permissions;
    });
  }
}
