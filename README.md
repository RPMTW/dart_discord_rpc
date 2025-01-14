<h1 align='center'><a href='https://github.com/RPMTW/dart_discord_rpc'>dart_discord_rpc</a></h1>
<h4 align='center'>Discord Rich Presence for Flutter & Dart apps & games.</h4>
<br></br>

<p align='center'><img height='160' src='https://raw.githubusercontent.com/RPMTW/dart_discord_rpc/main/image.png'></img>
</p>

## Install 

**Flutter**

```yaml
dependencies:
  ..
  dart_discord_rpc: ^0.0.1
```

**Dart CLI**

```yaml
dependencies:
  ..
  dart_discord_rpc_ffi: ^0.0.1
```

## Documentation

For integrating Discord Rich Presence into your application or game, you must create an application at [Discord Developer Portal](https://discord.com/developers/applications).

**Initialize the plugin.**

```dart
void main() {
    DiscordRPC.initialize();
    runApp(MyApp());
}
```

**Instantiate class.**

```dart
DiscordRPC rpc = DiscordRPC(
    applicationId: 'APPLICATION_ID',
);
```

**Set or change the user presence.**

```dart
rpc.start(autoRegister: true);
rpc.updatePresence(
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
```

**Clear the user presence.**

```dart
rpc.clearPresence();
```

**Listen to the events.**

```dart
rpc.events.listen((event) {
    if (event is DiscordReady) {
        event.user;
    }
    if (event is DiscordErrored) {
        event.errorCode;
        event.message;
    }
    if (event is DiscordJoinGame) {
        event.joinSecret;
    }
    // Other events.
});
```

There are other features for you to checkout.

Original project: https://github.com/alexmercerind/dart_discord_rpc

## Platforms 

Supported

- Windows
- Linux
- MacOS
