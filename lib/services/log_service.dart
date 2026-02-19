import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class LogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> logLogin({
    required String email,
    required bool success,
    String errorMessage = '',
  }) async {
    await _firestore.collection('login_logs').add({
      'email': email,
      'success': success,
      'error': errorMessage,
      'timestamp': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
      'action': 'login',
    });
  }
}
