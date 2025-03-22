import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _notificationsEnabled = false;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  Future<void> _checkNotificationPermission() async {
    var androidImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    var enabled = await androidImplementation?.areNotificationsEnabled();
    setState(() {
      _notificationsEnabled = enabled ?? false;
    });
  }

  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      setState(() {
        _notificationsEnabled = true;
      });
    } else {
      setState(() {
        _notificationsEnabled = false;
      });
    }
  }

  Future<void> _toggleNotifications(bool enabled) async {
    if (enabled) {
      await _requestNotificationPermission();
    } else {
      setState(() {
        _notificationsEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Settings')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text(
              'Enable Notifications',
              style: TextStyle(fontSize: 18.0),
            ),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              _toggleNotifications(value);
            },
          ),
        ],
      ),
    );
  }
}
