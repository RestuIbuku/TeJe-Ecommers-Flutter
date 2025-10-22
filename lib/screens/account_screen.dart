import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../widgets/gradient_background.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _name = '';
  String _email = '';
  String _deviceInfo = '';
  String _lastLogin = '';
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _getDeviceInfo();
    _setLastLogin();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('current_user');

    if (userString != null) {
      final userData = User.fromJson(jsonDecode(userString));
      setState(() {
        _name = userData.name;
        _email = userData.email;
      });
    }
  }

  Future<void> _getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        setState(() {
          _deviceInfo =
              '''
Perangkat: ${androidInfo.model}
Manufaktur: ${androidInfo.manufacturer}
Android: ${androidInfo.version.release}
SDK: ${androidInfo.version.sdkInt}
''';
        });
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        setState(() {
          _deviceInfo =
              '''
Perangkat: ${iosInfo.name}
Sistem: ${iosInfo.systemName}
Versi: ${iosInfo.systemVersion}
Model: ${iosInfo.model}
''';
        });
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfoPlugin.windowsInfo;
        setState(() {
          _deviceInfo =
              '''
Perangkat: ${windowsInfo.computerName}
OS: Windows ${windowsInfo.productName}
Versi: ${windowsInfo.displayVersion}
''';
        });
      } else {
        setState(() {
          _deviceInfo = 'Platform ${Platform.operatingSystem} terdeteksi';
        });
      }
    } catch (e) {
      setState(() {
        _deviceInfo = 'Tidak dapat membaca informasi perangkat';
      });
    }
  }

  void _setLastLogin() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, d MMMM yyyy HH:mm', 'id');
    setState(() {
      _lastLogin = formatter.format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akun Saya')),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _email,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi Perangkat:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_deviceInfo),
                      const SizedBox(height: 16),
                      Text(
                        'Login terakhir: $_lastLogin',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Keluar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
