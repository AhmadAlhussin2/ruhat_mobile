import 'dart:convert';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Quiz {
  final List<dynamic> questions;

  Quiz(this.questions);

  factory Quiz.fromJson(String rawJson) {
    List<dynamic> questions;
    if (rawJson == "Null") {
      questions = jsonDecode(
          '{"answer":"null", "options": ["null", "null", "null", "null"], "question": "null"}');
    } else {
      questions = jsonDecode(rawJson);
    }
    return Quiz(questions);
  }
}

const Color bgColor = Color.fromRGBO(169, 192, 198, 1);
