import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  static const platform = MethodChannel('flutter.native/helper');
  // Get battery level.
  String _gpsLocation = 'No Greeting From Method Channel.';

  Future<void> _getGPSLocation() async {
    String gpsLocation;
    try {
      final String result =
          await platform.invokeMethod("getCurrentGPSLocation");
      gpsLocation = 'This message come from channelMethod $result';
    } on PlatformException catch (e) {
      gpsLocation = "Failed to get current GPS Location: '${e.message}'.";
    }

    setState(() {
      _gpsLocation = gpsLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Location'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: Text(_gpsLocation))],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getGPSLocation,
        tooltip: 'Get',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
