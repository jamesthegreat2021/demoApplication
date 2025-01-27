import 'package:flutter/material.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
//recall this package will only run for mobile applications only
//for chrome applications it will not work
// import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asterisk real time events',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AsteriskEventsScreen(),
    );
  }
}

class AsteriskEventsScreen extends StatefulWidget {
  @override
  _AsteriskEventScreenState createState() => _AsteriskEventScreenState();
}

class _AsteriskEventScreenState extends State<AsteriskEventsScreen> {
  // websocket channel to connect to Asterisk ARI
  final WebSocketChannel channel = IOWebSocketChannel.connect(
    'ws://192.168.100.83:8088/ari/events?app=my_app&api_key=james:1234',
  );

  List<String> events = [];

  @override
  void initState() {
    super.initState();
    // Listen to WebSocket messages
    channel.stream.listen((message) {
      //sestate sets the state and allows for the rebuilding of the widget tree
      setState(() {
        events.add(message); // Add the event to the list
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close(); //close the websocket connection
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asterisk Real Time Events')),
      body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Event ${index+1}'),
              subtitle: Text(events[index]), 
            );
          }),
    );
  }
}
