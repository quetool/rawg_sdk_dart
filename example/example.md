##EXAMPLE

```
import 'package:flutter/material.dart';
import 'package:rawg_sdk_dart/core/game.dart';
import 'package:rawg_sdk_dart/rawg_sdk_dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _rawg = RawgApiClient();
  List<Game> list = [];

  @override
  void initState() {
    super.initState();
    _rawg.getGames(completion: (error, nextUrl, games) {
      setState(() {
        list = games;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example app',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(list[index].name),
              );
            },
            itemCount: list.length,
          ),
        ),
      ),
    );
  }
}

```