import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  var questions = {};

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Quiz"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
            child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/quiz", arguments: questions);
          },
          child: Text("start"),
        )));
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('questions_answers.json');
    final data = await json.decode(response);
    setState(() {
      questions = data;
    });
  }
}
