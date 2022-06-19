import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ruhat/models.dart';

Future<Quiz> getQuiz(name,pincode) async {
  final uri = Uri.https(
      'daber.space', '/api/get_quiz', {'id': pincode, 'name': name});
  final response =
      await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode == 200) {
    return Quiz.fromJson(response.body);
  } else {
    // print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

postAnswer(String userAnswer, String correctAnswer, String name, String pincode) async {
  if (userAnswer == correctAnswer) {
    final uri = Uri.https(
        'daber.space', '/api/post_answer', {'name': name,'id': pincode,'correct': 'true'});
    final response = await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
    print(response.body);
    return true;
  } else {
    final uri = Uri.https(
        'daber.space', '/api/post_answer', {'name': name,'id': pincode,'correct': 'false'});
    final response = await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
    print(response.body);
    return false;
  }
}

Future<Map<String, dynamic>> getResult(String name, String pincode) async {
    final uri = Uri.https(
        'daber.space', '/api/get_result', {'name': name,'id': pincode});
    final response = await http.get(uri, headers: {"Access-Control-Allow-Origin": "*",'Content-Type': 'application/json'});
    // print(response.body);
    return jsonDecode(response.body);
}
