import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_discord_rpc/dart_discord_rpc.dart';

late DiscordRPC discord;
void main() async {
  discord = DiscordRPC(
      applicationId: 903883530822627370, libTempPath: Directory.systemTemp);
  await discord.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // with WidgetsBindingObserver
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addObserver(this);
    discord.handler.start(autoRegister: true);
    discord.handler.updatePresence(
      DiscordPresence(
        state: 'Discord Rich Presence from Dart. 🎯',
        details: 'github.com/alexmercerind/dart_discord_rpc',
        startTimeStamp: DateTime.now().millisecondsSinceEpoch,
        largeImageKey: 'large_image',
        largeImageText: 'This text describes the large image.',
        smallImageKey: 'small_image',
        smallImageText: 'This text describes the small image.',
      ),
    );
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state.name);
  //   if (state == AppLifecycleState.paused) {
  //     discord.quit();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('dart_discord_rpc'),
        ),
        body: Center(
          child: Text('Open Discord to see the plugin working.'),
        ),
      ),
    );
  }
}
