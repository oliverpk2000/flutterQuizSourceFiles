import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int question_counter = 0;
  int questions_correct = 0;
  bool question_answered = false;
  bool end = false;
  int answer_index = 0;
  var question_answer_pairs = {};
  bool shuffled = false;

  @override
  Widget build(BuildContext context) {
    question_answer_pairs = ModalRoute.of(context)!.settings.arguments as Map;
    var length = question_answer_pairs["question_answer_pairs"]?.length;
    var answers = question_answer_pairs["question_answer_pairs"]!
        .elementAt(question_counter)["answers"] as List;
    if(!shuffled){
      answers.shuffle();
      shuffled = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Quiz"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
          child: Column(children: [
        Text(question_answer_pairs["question_answer_pairs"]!
            .elementAt(question_counter)["question"]
            .toString()),
        Expanded(
            child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              leading: IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  if (question_answered) {
                    return null;
                  }
                  setState(() {
                    question_answered = true;
                    answer_index = index;
                  });
                },
              ),
              title: Text(answers[index]["answer"].toString(),
                  style: (question_answered)
                      ? ((answers[index]["validity"])
                          ? TextStyle(backgroundColor: Colors.green)
                          : TextStyle(backgroundColor: Colors.red))
                      : TextStyle(backgroundColor: Colors.white)),
            );
          },
        )),
        (question_answered)
            ? ElevatedButton(
                onPressed: () async {
                  var validity = answers[answer_index]["validity"] as bool;
                  if (validity) {
                    setState(() {
                      if (question_counter == length! - 1) {
                        questions_correct++;
                        end = true;
                      } else {
                        question_counter++;
                        questions_correct++;
                      }
                      shuffled = false;
                      question_answered = false;
                    });
                  } else {
                    setState(() {
                      if (question_counter == length! - 1) {
                        question_counter++;
                      } else {
                        end = true;
                      }
                      shuffled = false;
                      question_answered = false;
                    });
                  }
                  var args = await Navigator.pushNamed(context, '/result',
                      arguments: [
                        (end) ? question_counter + 1 : question_counter,
                        length,
                        questions_correct
                      ]) as List;
                  setState(() {
                    question_counter = args[0];
                    questions_correct = args[2];
                    end = false;
                    question_answered = false;
                  });
                },
                child: Text("Next"))
            : Text("answer the question", style: TextStyle(color: Colors.black))
      ])),
    );
  }
}
