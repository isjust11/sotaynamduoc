import 'package:flutter/material.dart';
import 'package:sotaynamduoc/services/fcm_service.dart';
import 'package:sotaynamduoc/services/api_service.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/injection_container.dart' as getIt;
import 'package:sotaynamduoc/domain/repositories/fcm_repository.dart';

class FCMTestScreen extends StatefulWidget {
  const FCMTestScreen({super.key});

  @override
  State<FCMTestScreen> createState() => _FCMTestScreenState();
}

class _FCMTestScreenState extends State<FCMTestScreen> {
  final FCMService _fcmService = FCMService(fcmRepository: getIt.getIt.get<FcmRepository>());
  final ApiService _apiService = ApiService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _topicController = TextEditingController(
    text: 'test',
  );

  @override
  void initState() {
    super.initState();
    _apiService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      customAppBar: BaseAppBar(
        title: 'FCM Test',
        backgroundColor: AppColors.secondaryBrand,
        actions: [],
        centerTitle: true,
        showBackButton: true,
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // FCM Token Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FCM Token Info',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'FCM Token: ${_fcmService.fcmToken ?? 'Not available'}',
                        ),
                        Text(
                          'Notifications Enabled: ${_fcmService.notificationsEnabled}',
                        ),
                        FutureBuilder<bool>(
                          future: _fcmService.isAPNSTokenReady(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text('APNS Token Ready: ${snapshot.data}');
                            }
                            return const Text('APNS Token: Checking...');
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Topic Management
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Topic Management',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _topicController,
                          decoration: const InputDecoration(
                            labelText: 'Topic Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _fcmService.subscribeToTopic(
                                    _topicController.text,
                                  );
                                  _showSnackBar(
                                    'Subscribed to topic: ${_topicController.text}',
                                  );
                                },
                                child: const Text('Subscribe'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _fcmService.unsubscribeFromTopic(
                                    _topicController.text,
                                  );
                                  _showSnackBar(
                                    'Unsubscribed from topic: ${_topicController.text}',
                                  );
                                },
                                child: const Text('Unsubscribe'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Send Test Notification
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Send Test Notification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _bodyController,
                          decoration: const InputDecoration(
                            labelText: 'Body',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            if (_titleController.text.isNotEmpty &&
                                _bodyController.text.isNotEmpty) {
                              final success = await _apiService
                                  .sendTestNotification(
                                    _titleController.text,
                                    _bodyController.text,
                                  );
                              _showSnackBar(
                                success
                                    ? 'Test notification sent!'
                                    : 'Failed to send notification',
                              );
                            } else {
                              _showSnackBar('Please fill in title and body');
                            }
                          },
                          child: const Text('Send Test Notification'),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Notification Settings
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notification Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SwitchListTile(
                          title: const Text('Enable Notifications'),
                          value: _fcmService.notificationsEnabled,
                          onChanged: (value) async {
                            await _fcmService.toggleNotifications(value);
                            setState(() {});
                            _showSnackBar(
                              'Notifications ${value ? 'enabled' : 'disabled'}',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
