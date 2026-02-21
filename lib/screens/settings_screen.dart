import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Access Settings")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final data = user.data() as Map<String, dynamic>;

              final permissions = data['permissions'] ?? {};
              final accessSchedule = data['accessSchedule'] ?? {};

              final bool scheduleEnabled = accessSchedule['enabled'] ?? false;
              final String startTime = accessSchedule['startTime'] ?? "09:00";
              final String endTime = accessSchedule['endTime'] ?? "17:00";
              final Map<String, dynamic> days =
                  accessSchedule['days'] ?? {};

              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text(data['email'] ?? "User"),
                  children: [
                    _buildPermissionsSection(user.id, permissions),
                    const Divider(),
                    _buildAccessScheduleSection(
                      context,
                      user.id,
                      scheduleEnabled,
                      days,
                      startTime,
                      endTime,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ---------------- PERMISSIONS ----------------

  Widget _buildPermissionsSection(String userId, Map permissions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text("🔐 Permissions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        _permissionTile(userId, permissions, 'showPrice', 'Retail Price'),
        _permissionTile(userId, permissions, 'showInstallerPrice', 'Installer Price'),
        _permissionTile(userId, permissions, 'showWholesalePrice', 'Wholesale Price'),
        _permissionTile(userId, permissions, 'canEdit', 'Can Edit'),
        _permissionTile(userId, permissions, 'canDelete', 'Can Delete'),
      ],
    );
  }

  Widget _permissionTile(
      String userId, Map permissions, String key, String label) {
    return CheckboxListTile(
      title: Text(label),
      value: permissions[key] ?? false,
      onChanged: (value) {
        FirebaseFirestore.instance.collection('users').doc(userId).update({
          'permissions.$key': value,
        });
      },
    );
  }

  // ---------------- ACCESS SCHEDULE ----------------

  Widget _buildAccessScheduleSection(
      BuildContext context,
      String userId,
      bool enabled,
      Map<String, dynamic> days,
      String startTime,
      String endTime,
      ) {
    final bool noDaysSelected = !days.values.any((d) => d == true);

    final bool invalidTime = _timeToMinutes(endTime) <= _timeToMinutes(startTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text("⏰ Access Schedule",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),

        SwitchListTile(
          title: const Text("Enable Time Restriction"),
          value: enabled,
          onChanged: (value) {
            FirebaseFirestore.instance.collection('users').doc(userId).update({
              'accessSchedule.enabled': value,
            });
          },
        ),

        if (enabled) ...[
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text("Days Allowed"),
          ),

          Wrap(
            spacing: 6,
            children: [
              _dayChip(userId, days, "monday", "Mon"),
              _dayChip(userId, days, "tuesday", "Tue"),
              _dayChip(userId, days, "wednesday", "Wed"),
              _dayChip(userId, days, "thursday", "Thu"),
              _dayChip(userId, days, "friday", "Fri"),
              _dayChip(userId, days, "saturday", "Sat"),
              _dayChip(userId, days, "sunday", "Sun"),
            ],
          ),

          const SizedBox(height: 12),

          ListTile(
            title: const Text("Start Time"),
            trailing: Text(startTime),
            onTap: () => _pickTime(context, userId, "startTime", startTime),
          ),
          ListTile(
            title: const Text("End Time"),
            trailing: Text(endTime),
            onTap: () => _pickTime(context, userId, "endTime", endTime),
          ),

          if (noDaysSelected || invalidTime)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "⚠ Warning: This user will never be able to access the app with current settings.",
                style: TextStyle(color: Colors.red),
              ),
            ),
        ]
      ],
    );
  }

  // ---------------- DAY CHIP ----------------

  Widget _dayChip(String userId, Map<String, dynamic> days, String key, String label) {
    final bool selected = days[key] ?? false;

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (value) {
        FirebaseFirestore.instance.collection('users').doc(userId).update({
          'accessSchedule.days.$key': value,
        });
      },
    );
  }

  // ---------------- TIME PICKER ----------------

  Future<void> _pickTime(
      BuildContext context, String userId, String field, String currentTime) async {
    final parts = currentTime.split(":");
    final initialTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      final formatted =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

      FirebaseFirestore.instance.collection('users').doc(userId).update({
        'accessSchedule.$field': formatted,
      });
    }
  }

  int _timeToMinutes(String time) {
    final parts = time.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}