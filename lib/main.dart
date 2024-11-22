import 'package:flutter/material.dart';
import 'package:notification/notification/notification.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  NotificationService.showInstantNotification(
                      'Drop Watar', 'This time to drop watar on tree 💦💧');
                },
                child: const Text('Show')),
            ElevatedButton(
                onPressed: () {
                  DateTime shedualTime =
                      DateTime.now().add(const Duration(minutes: 1));
                  NotificationService.shedualNotification("Drop watar",
                      "Now secend time a day to drop watar 💧💧", shedualTime);
                },
                child: const Text('Shedule')),
                        ElevatedButton(
                onPressed: () {
          
                },
                child: const Text('Work')),
          ],
        ),
      ),
    );
  }
}
