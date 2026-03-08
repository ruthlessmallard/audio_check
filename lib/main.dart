import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const AudioCheckApp());
}

class AudioCheckApp extends StatelessWidget {
  const AudioCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Check',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MicTestScreen(),
    );
  }
}

class MicTestScreen extends StatefulWidget {
  const MicTestScreen({super.key});

  @override
  State<MicTestScreen> createState() => _MicTestScreenState();
}

class _MicTestScreenState extends State<MicTestScreen> {
  String _statusMessage = "Press the button to test mic permissions.";
  Color _statusColor = Colors.grey;

  Future<void> _testMicPermission() async {
    final status = await Permission.microphone.request();

    setState(() {
      if (status.isGranted) {
        _statusMessage = "✅ Permission Granted";
        _statusColor = Colors.green;
      } else if (status.isDenied) {
        _statusMessage = "❌ Permission Denied";
        _statusColor = Colors.red;
      } else if (status.isPermanentlyDenied) {
        _statusMessage = "🚫 Permanently Denied — open Settings";
        _statusColor = Colors.orange;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Check — I am Doug 🦆"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _statusMessage,
              style: TextStyle(fontSize: 20, color: _statusColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _testMicPermission,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                textStyle: const TextStyle(fontSize: 22),
              ),
              child: const Text("🎙️ Test Mic"),
            ),
          ],
        ),
      ),
    );
  }
}
