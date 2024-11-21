import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: IconSwitcherScreen(),
    );
  }
}

class IconSwitcherScreen extends StatefulWidget {
  @override
  _IconSwitcherScreenState createState() => _IconSwitcherScreenState();
}

class _IconSwitcherScreenState extends State<IconSwitcherScreen> {
  static const platform = MethodChannel('com.example.app/icon');

  Future<void> _switchAppIcon(bool isChristmas) async {
    try {
      await platform
          .invokeMethod('switchAppIcon', {'isChristmas': isChristmas});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('App icon switched successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error switching app icon: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Icon Switcher')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _switchAppIcon(true),
              child: Text('เปลี่ยนเป็นไอคอนคริสต์มาส'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _switchAppIcon(false),
              child: Text('เปลี่ยนเป็นไอคอนปกติ'),
            ),
          ],
        ),
      ),
    );
  }
}
