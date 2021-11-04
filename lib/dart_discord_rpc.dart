// ignore_for_file: implementation_imports
import 'dart:io';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:dart_discord_rpc_ffi/dart_discord_rpc_ffi.dart' as ffi;
import 'package:uuid/uuid.dart';
export 'package:dart_discord_rpc_ffi/dart_discord_rpc_ffi.dart' hide DiscordRPC;

/// ## Discord Rich Presence for Dart & Flutter.
///
/// For integrating Discord Rich Presence into your application or game, you must create an
/// application at [Discord Developer Portal](https://discord.com/developers/applications).
///
/// Initialize the plugin.
/// ```dart
/// void main() {
///   DiscordRPC.initialize();
///   runApp(MyApp());
/// }
/// ```
///
/// Example
///
/// ```dart
/// var rpc = DiscordRPC(
///   applicationId: '877853131025809438',
/// );
/// rpc.start(autoRegister: true);
/// rpc.updatePresence(
///   DiscordPresence(
///     state: 'Discord Rich Presence from Dart. 🎯',
///     details: 'github.com/alexmercerind/dart_discord_rpc',
///     startTimeStamp: DateTime.now().millisecondsSinceEpoch,
///     largeImageKey: 'large_image',
///     largeImageText: 'This text describes the large image.',
///     smallImageKey: 'small_image',
///     smallImageText: 'This text describes the small image.',
///   ),
/// );
/// ```
///
class DiscordRPC {
  late String libName;
  late File libFile;
  late DiscordRPCHandler handler;

  int applicationId;
  String? steamId;

  DiscordRPC(
      {required this.applicationId, this.steamId, Directory? libTempPath}) {
    libName = _getLibraryFileName('discord-rpc.so');
    libFile = File(join((libTempPath ?? Directory.systemTemp).absolute.path,
        "${Uuid().v4()}-$libName"));
  }

  /// Initializes the plugin.
  ///
  /// ```dart
  /// void main() {
  ///   DiscordRPC.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    Uint8List libBytes =
        (await rootBundle.load("packages/dart_discord_rpc/ffi-bin/$libName"))
            .buffer
            .asUint8List();

    libFile
      ..createSync(recursive: true)
      ..writeAsBytesSync(libBytes);

    handler = DiscordRPCHandler(
        applicationId: applicationId,
        steamId: steamId,
        dynamicLibrary: DynamicLibrary.open(libFile.path));

    quit();
  }

  void quit() {
    libFile.deleteSync(recursive: true);
  }

  String _getLibraryFileName(String filename) {
    // Windows doesn't use
    if (!Platform.isWindows) filename = 'lib$filename';

    return setExtension(filename, _getPlatformExtension());
  }

  String _getPlatformExtension() {
    if (Platform.isLinux) return '.so';
    if (Platform.isMacOS) return '.dylib';
    if (Platform.isWindows) return '.dll';
    throw 'Unsupported platform ${Platform.operatingSystem}';
  }
}

class DiscordRPCHandler extends ffi.DiscordRPC {
  DiscordRPCHandler(
      {required int applicationId,
      required DynamicLibrary dynamicLibrary,
      String? steamId})
      : super(
          dynamicLibrary: dynamicLibrary,
          applicationId: applicationId.toString(),
          steamId: steamId,
        );
}
