import 'package:flutter/material.dart';
import 'package:flutterdoctor/quiz.dart';
import 'package:flutterdoctor/result.dart';

class MindTest extends StatefulWidget {
  @override
  _MindTestState createState() => _MindTestState();
}

class _MindTestState extends State<MindTest> {
  final _questions = const [
    {
      'questionText':
          'Were you so nervous or worried that you couldn’t think about anything else, no matter how hard you tried?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText':
          'Did you worry so much or so strongly about only one topic?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText':
          'Do you think that during the past month your worry and anxiety was a lot stronger than it should have been?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText':
          'Did you feel so sad that nothing could cheer you up for at least several days?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText': 'Did you have a lot of trouble falling asleep?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText':
          'Were you often thinking about death; either your own, someone else’s, or death in general?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText':
          'Has anyone at home hit you or tried to injure you in any way?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText':
          'Has anyone forced you to engage in sexual activities that you didn’t want?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText': 'Do you feel controlled or isolated by anyone?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText': 'Do you regret making your own decisions?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText': 'Are you compatible about needs for affection and sex?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText':
          'Do you feel that she/he always has your back, that you can always go to her for help?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText': 'Has anyone close to you ever threatened or hurt you?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
    {
      'questionText': 'Are you compatible about needs for affection and sex?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 5},
        {'text': 'Confused', 'score': 3},
        {'text': 'Neutral', 'score': 1},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    // var aBool = true;
    // aBool = false;

    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var dummy = const ['Hello'];
    // dummy.add('Max');
    // print(dummy);
    // dummy = [];
    // questions = []; // does not work if questions is a const

    return Scaffold(
      appBar: AppBar(
        title: Text('Mind Test'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(_totalScore, _resetQuiz),
    );
  }
}
