import 'package:http/http.dart' as http;
import 'package:ruhat/models.dart';

Future<Quiz> getQuiz() async {
  final uri = Uri.https(
      'daber.space', '/api/get_quiz', {'id': "123", 'name': "Student"});
  final response =
      await http.get(uri, headers: {"Access-Control-Allow-Origin": "*"});
  if (response.statusCode == 200) {
    return Quiz.fromJson(response.body);
  } else {
    return Quiz.fromJson("Null");
  }
}

checkAnswer(String userAnswer, String correctAnswer) {
  if (userAnswer == correctAnswer) {
    return true;
  } else {
    return false;
  }
}
