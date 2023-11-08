import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var args = [];

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as List;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Quiz"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        child: Column(children: [
          Text("${args[0]}/${args[1]} questions answered"),
          Text("${args[2]}/${args[0]} questions correct"),
          (args[0] == args[1])
              ? ElevatedButton(
                  onPressed: () => {
                        Navigator.pop(context, [0, args[1], 0])
                      },
                  child: Text("retake quiz"))
              : ElevatedButton(
                  onPressed: () => {Navigator.pop(context, args)},
                  child: Text("next question"))
        ]),
      ),
    );
  }
}
