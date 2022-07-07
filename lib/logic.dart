import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ruhat/models.dart';
import 'package:ruhat/quiz_page.dart';
import 'dart:io';
import 'finish_quiz.dart';

Future<Quiz> getQuiz(name,pincode) async {
  final uri = Uri.https(
      'daber.space', '/api/get_quiz', {'id': pincode, 'name': name});
  final response =
      await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode == 200) {
    return Quiz.fromJson(response.body);
  } else {
    throw Exception(response.statusCode);
  }
}

Future<bool> postAnswer(String userAnswer, String correctAnswer, String name, String pincode) async {
  if (userAnswer == correctAnswer) {
    final uri = Uri.https(
        'daber.space', '/api/post_answer', {'name': name,'id': pincode,'correct': 'true'});
    await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
    return true;
  } else {
    final uri = Uri.https(
        'daber.space', '/api/post_answer', {'name': name,'id': pincode,'correct': 'false'});
    await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
    return false;
  }
}

Future<Map<String, dynamic>> getResult(String name, String pincode) async {
    final uri = Uri.https(
        'daber.space', '/api/get_result', {'name': name,'id': pincode});
    final response = await http.get(uri, headers: {"Access-Control-Allow-Origin": "*",'Content-Type': 'application/json'});
    return jsonDecode(response.body);
}


enterButtonPressed(name,code,context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context){
      print("Quiz page is opened");
      return QuizPage(name: name,pincode: code);
    }),
  );
}
optionButtonPressed(context,optionStatement, correctAnswer, name,code){
  var result = postAnswer(
      optionStatement, correctAnswer, name, code);
}
dynamic checkNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}