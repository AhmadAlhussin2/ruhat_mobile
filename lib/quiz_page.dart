import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuizForm(),
    );
  }
}
class QuizForm extends StatefulWidget {
  const QuizForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizFormState();

}

class _QuizFormState extends State<QuizForm> {
  @override
  Widget build(BuildContext context) {
    // TODO: make a design for a quiz page
    throw Error();
  }

}