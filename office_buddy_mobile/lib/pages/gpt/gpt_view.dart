import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("AI问答"),
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(children: [
        Row(
          children: <Widget>[
            Spacer(),
            Card(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Text(
                            'Your Text here dddaaaffffffffffffffffffffffffffffffff\naaa'))))
          ],
        ),
        Row(
          children: <Widget>[
            Card(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Text(
                            'Your Text here dddaaaffffffffffffffffffffffffffffffff\naaa')))),
            Spacer()
          ],
        ),
        Row(
          children: <Widget>[
            Spacer(),
            Card(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Text(
                            'Your Text here dddaaaffffffffffffffffffffffffffffffff\naaa'))))
          ],
        ),
      ]));
}
