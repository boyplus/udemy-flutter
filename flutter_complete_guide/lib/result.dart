import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuiz;
  Result(this.resultScore, this.resetQuiz);

  String getResultPhrase() {
    String resultText;
    if (resultScore >= 3) {
      resultText = 'You are so good';
    } else if (resultScore >= 2) {
      resultText = 'You are ok';
    } else if (resultScore >= 1) {
      resultText = 'You did not that well';
    } else {
      resultText = 'You are so bad';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Text(
          getResultPhrase(),
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text('Restart Quiz'),
          onPressed: resetQuiz,
          textColor: Colors.blue,
        )
      ]),
    );
  }
}
