import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Quiz {
  final List<dynamic>questions;
  Quiz(this.questions);
  factory Quiz.fromJson(String rawJson) {
    List<dynamic> questions = jsonDecode(rawJson);
    return Quiz(questions);
  }
}

Future<void> fetchQuestions() async {
  final uri = Uri.https('daber.space','/api/get_quiz',{'id':"123", 'name':"Student"});
  final response = await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode==200){
    print(Quiz.fromJson(response.body).questions[0]);
  } else {
    print("error");
  }
}