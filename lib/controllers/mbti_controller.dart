import 'package:course_guide/models/question.dart';
import 'package:course_guide/util/questions.dart';
import 'package:flutter/cupertino.dart';

class MBTIController extends ChangeNotifier {
  String? _mbti;

  String? get mbti => _mbti;

  final E = {
    '3A': 2,
    '6A': 2,
    '9A': 2,
    '13A': 2,
    '16A': 2,
    '21A': 2,
    '24A': 2,
    '26A': 2,
    '29B': 2,
    '36B': 2,
    '43B': 2,
  };

  final I = {
    '3B': 2,
    '6B': 2,
    '9B': 2,
    '13B': 2,
    '16B': 2,
    '21B': 2,
    '24B': 2,
    '26B': 2,
    '29A': 2,
    '36A': 2,
    '43A': 2,
  };

  final S = {
    '1A': 2,
    '5B': 2,
    '10A': 2,
    '12A': 2,
    '15B': 2,
    '20A': 2,
    '23B': 2,
    '28A': 2,
    '31B': 2,
    '35A': 2,
    '38B': 2,
    '42A': 2,
    '45B': 2,
    '48A': 2,
  };

  final N = {
    '1B': 2,
    '5A': 2,
    '10B': 2,
    '12B': 2,
    '15A': 2,
    '20B': 2,
    '23A': 2,
    '28B': 2,
    '31A': 2,
    '35B': 2,
    '38A': 2,
    '42B': 2,
    '45A': 2,
    '48B': 2,
  };

  final T = {
    '4B': 2,
    '14B': 2,
    '22B': 2,
    '30A': 2,
    '32A': 2,
    '33A': 2,
    '37A': 2,
    '39A': 2,
    '40B': 2,
    '44A': 2,
    '46A': 2,
    '47B': 2,
    '49A': 2,
    '50A': 2,
  };

  final F = {
    '4A': 2,
    '14A': 2,
    '22A': 2,
    '30B': 2,
    '32B': 2,
    '33B': 2,
    '37B': 2,
    '39B': 2,
    '40A': 2,
    '44B': 2,
    '46B': 2,
    '47A': 2,
    '49B': 2,
    '50B': 2,
  };

  final J = {
    '1A': 2,
    '7A': 2,
    '8A': 2,
    '11A': 2,
    '17A': 2,
    '18A': 2,
    '19A': 2,
    '25A': 2,
    '25C': 2,
    '27A': 2,
    '34A': 2,
    '41A': 2,
  };

  final P = {
    '1B': 2,
    '7B': 2,
    '8B': 2,
    '11B': 2,
    '17B': 2,
    '18B': 2,
    '19B': 2,
    '25B': 2,
    '27B': 2,
    '34B': 2,
    '41B': 2,
  };






  String personalityType = '';

  List<Map<String,dynamic>> get _questions {
    return questions..sort((a, b) => int.parse(a.entries.first.key.substring(1)).compareTo(int.parse(b.entries.first.key.substring(1))));
  }

  int _currentQuestionIndex = 1;

  int get currentQuestionIndex => _currentQuestionIndex;

  Map get currentQuestion => _questions[_currentQuestionIndex-1];
  Map<String, dynamic> points = {
    'E': 0,
    'I': 0,
    'S': 0,
    'N': 0,
    'T': 0,
    'F': 0,
    'J': 0,
    'P': 0,
  };



  void updateAnswer(String answer) {

    String key = '${_currentQuestionIndex}$answer';

    // check if key exists in the map of E/I, S/N, T/F, J/P
    if (E.containsKey(key)) {
      points['E'] += E[key];
    } else if (I.containsKey(key)) {
      points['I'] += I[key];
    } else if (S.containsKey(key)) {
      points['S'] += S[key];
    } else if (N.containsKey(key)) {
      points['N'] += N[key];
    } else if (T.containsKey(key)) {
      points['T'] += T[key];
    } else if (F.containsKey(key)) {
      points['F'] += F[key];
    } else if (J.containsKey(key)) {
      points['J'] += J[key];
    } else if (P.containsKey(key)) {
      points['P'] += P[key];
    }

    _currentQuestionIndex++;
    if (_currentQuestionIndex >= _questions.length) {
      calculatePersonalityType();
      _currentQuestionIndex = 1;
    }

    notifyListeners();
  }

  void calculatePersonalityType() {
    personalityType = '';
    if (points['E'] > points['I']) {
      personalityType += 'E';
    } else {
      personalityType += 'I';
    }
    if (points['S'] > points['N']) {
      personalityType += 'S';
    } else {
      personalityType += 'N';
    }
    if (points['T'] > points['F']) {
      personalityType += 'T';
    } else {
      personalityType += 'F';
    }
    if (points['J'] > points['P']) {
      personalityType += 'J';
    } else {
      personalityType += 'P';
    }

    notifyListeners();
  }

  set mbti(String? value) {
    _mbti = value;
    notifyListeners();
  }




}