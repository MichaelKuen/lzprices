import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class AccessResult {
  final bool allowed;
  final String message;

  AccessResult({required this.allowed, required this.message});
}

class AccessControlService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<AccessResult> get accessStream async* {
    final user = _auth.currentUser;
    if (user == null) {
      yield AccessResult(allowed: false, message: "User not logged in");
      return;
    }

    tzdata.initializeTimeZones();

    // Listen to Firestore user document
    await for (var snapshot in _firestore.collection('users').doc(user.uid).snapshots()) {
      if (!snapshot.exists) {
        yield AccessResult(allowed: false, message: "User record not found");
        continue;
      }

      final data = snapshot.data()!;
      final permissions = Map<String, dynamic>.from(data['permissions'] ?? {});
      final accessDays = Map<String, dynamic>.from(permissions['accessDays'] ?? {});
      final startTime = permissions['accessStartTime'] as String? ?? '09:00';
      final endTime = permissions['accessEndTime'] as String? ?? '17:00';
      final timezone = permissions['timezone'] as String? ?? 'Africa/Johannesburg';

      final nowUtc = DateTime.now().toUtc();
      final location = tz.getLocation(timezone);
      final now = tz.TZDateTime.from(nowUtc, location);

      final weekdayNames = [
        'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'
      ];
      final todayName = weekdayNames[now.weekday - 1]; // DateTime.weekday: 1=Monday

      final allowedToday = accessDays[todayName] ?? false;

      if (!allowedToday) {
        yield AccessResult(
          allowed: false,
          message: "Access blocked today ($todayName)",
        );
        continue;
      }

      // Convert times to minutes
      final startParts = startTime.split(':').map(int.parse).toList();
      final endParts = endTime.split(':').map(int.parse).toList();
      final nowMinutes = now.hour * 60 + now.minute;
      final startMinutes = startParts[0] * 60 + startParts[1];
      final endMinutes = endParts[0] * 60 + endParts[1];

      if (nowMinutes < startMinutes || nowMinutes > endMinutes) {
        yield AccessResult(
          allowed: false,
          message: "Access allowed between $startTime and $endTime ($timezone)",
        );
      } else {
        yield AccessResult(
          allowed: true,
          message: "Access granted",
        );
      }
    }
  }
}