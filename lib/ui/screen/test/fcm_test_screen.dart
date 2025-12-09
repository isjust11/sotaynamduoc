import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/services/fcm_service.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/injection_container.dart' as getIt;
import 'package:sotaynamduoc/domain/repositories/fcm_repository.dart';
import 'package:sotaynamduoc/blocs/fcm_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';

class FCMTestScreen extends StatelessWidget {
  const FCMTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FCMTestScreenContent();
  }
}

class _FCMTestScreenContent extends StatefulWidget {
  const _FCMTestScreenContent();

  @override
  State<_FCMTestScreenContent> createState() => _FCMTestScreenState();
}

class _FCMTestScreenState extends State<_FCMTestScreenContent> {
  final FCMService _fcmService = FCMService(
    fcmRepository: getIt.getIt.get<FcmRepository>(),
  );
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _topicController = TextEditingController(
    text: 'test',
  );
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FcmCubit, BaseState>(
      listener: (context, state) {
        if (state is LoadingState) {
          setState(() {
            _isLoading = true;
          });
        } else if (state is LoadedState) {
          setState(() {
            _isLoading = false;
          });
          _showSnackBar('Operation completed successfully!', isError: false);
        } else if (state is ErrorState) {
          setState(() {
            _isLoading = false;
          });
          _showSnackBar('Error: ${state.message}', isError: true);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            _buildMainContent(context),
            if (_isLoading)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMainContent(BuildContext context) {
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
                        Row(
                          children: [
                            Expanded(
                              child: SelectableText(
                                'FCM Token: ${_fcmService.fcmToken ?? 'Not available'}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            if (_fcmService.fcmToken != null)
                              IconButton(
                                icon: const Icon(Icons.copy, size: 20),
                                onPressed: () {
                                  // Copy to clipboard would need clipboard package
                                  _showSnackBar('Token: ${_fcmService.fcmToken}');
                                },
                                tooltip: 'Show full token',
                              ),
                          ],
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

                // Permission Status
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notification Permission',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<bool>(
                          future: _fcmService.isPermissionGranted(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text('Checking permission...');
                            }
                            
                            final isGranted = snapshot.data ?? false;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      isGranted ? Icons.check_circle : Icons.cancel,
                                      color: isGranted ? Colors.green : Colors.red,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      isGranted ? 'Permission Granted ✅' : 'Permission Denied ❌',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isGranted ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                if (!isGranted) ...[
                                  const SizedBox(height: 8),
                                  const Text(
                                    '⚠️ You need to enable notifications in Settings',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.settings),
                                    label: const Text('Request Permission'),
                                    onPressed: () async {
                                      final granted = await _fcmService.requestPermissionAgain();
                                      setState(() {});
                                      _showSnackBar(
                                        granted 
                                          ? 'Permission granted!' 
                                          : 'Permission denied. Please enable in Settings.',
                                        isError: !granted,
                                      );
                                    },
                                  ),
                                ],
                                const SizedBox(height: 8),
                                FutureBuilder<Map<String, dynamic>>(
                                  future: _fcmService.getPermissionStatus(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) return const SizedBox.shrink();
                                    
                                    final status = snapshot.data!;
                                    return ExpansionTile(
                                      title: const Text('Detailed Status'),
                                      children: [
                                        ...status.entries.map((e) => 
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(e.key),
                                                Text(e.value.toString()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryBrand,
                                  foregroundColor: AppColors.white,
                                ),
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        // Subscribe using both FCM service and API
                                        await context
                                            .read<FcmCubit>()
                                            .subscribeToTopic(
                                              topic: _topicController.text,
                                            );
                                      },
                                child: const Text('Subscribe'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        // Unsubscribe using both FCM service and API
                                        await context
                                            .read<FcmCubit>()
                                            .unsubscribeFromTopic(
                                              topic: _topicController.text,
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
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        if (_titleController.text.isNotEmpty &&
                                            _bodyController.text.isNotEmpty &&
                                            _topicController.text.isNotEmpty) {
                                          context.read<FcmCubit>().sendToTopic(
                                            topic: _topicController.text,
                                            title: _titleController.text,
                                            body: _bodyController.text,
                                          );
                                        } else {
                                          _showSnackBar(
                                            'Please fill in all fields',
                                            isError: true,
                                          );
                                        }
                                      },
                                child: const Text('Send to Topic'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        final token = _fcmService.fcmToken;
                                        if (_titleController.text.isNotEmpty &&
                                            _bodyController.text.isNotEmpty &&
                                            token != null) {
                                          context.read<FcmCubit>().sendToToken(
                                            token: token,
                                            title: _titleController.text,
                                            body: _bodyController.text,
                                          );
                                        } else {
                                          _showSnackBar(
                                            'Please fill in all fields and ensure FCM token is available',
                                            isError: true,
                                          );
                                        }
                                      },
                                child: const Text('Send to This Device'),
                              ),
                            ),
                          ],
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

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
