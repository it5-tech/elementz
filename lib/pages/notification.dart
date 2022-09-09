//https://github.com/Coding-Orbit/flutter_local_notification/blob/main/lib/screens/home.dart
import 'package:flutter/material.dart';
import 'package:elementz/pages/second_screen.dart';
import 'package:elementz/assets/services/local_notification_service.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotification(
                          id: 0,
                          title: 'Notification Title',
                          body: 'Some body');
                    },
                    child: const Text('Show Local Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showScheduledNotification(
                        id: 0,
                        title: 'Notification Title',
                        body: 'Some body',
                        seconds: 4,
                      );
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotificationWithPayload(
                          id: 0,
                          title: 'Notification Title',
                          body: 'Some body',
                          payload: 'payload navigation');
                    },
                    child: const Text('Show Notification With Payload'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}
