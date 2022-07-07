import 'package:flutter/material.dart';
import 'package:ruhat/logic.dart';
import 'package:ruhat/models.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'finish_quiz.dart';
import 'package:ruhat/theme_data.dart';

class QuizPage extends StatefulWidget {
  final String name;
  final String pincode;
  const QuizPage({Key? key, required this.name, required this.pincode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final listOfOptions = ["A", "B", "C", "D"];
  late Quiz quiz;
  var quizLength = 0;
  late String name;
  late String pincode;

  // State
  bool _isLoading = false;
  bool _hasInternet = true;
  var index = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    checkNetwork().then((connection) {
      setState((){
        _hasInternet = connection;
      });
    });
    getQuiz(widget.name, widget.pincode).then((data) {
      setState(() {
        quiz = data;
        _isLoading = false;
      });
      quizLength = quiz.questions.length;
    }).catchError(handleError);
    name = widget.name;
    pincode = widget.pincode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: _isLoading ? _buildLoading() : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (name != null && pincode != null) {
      return _buildQuiz();
    } else {
      return _buildException();
    }
  }

  Widget _buildException() {
    return const Center(
      child: Text("Exception in _buildBody(), name==null or code==null"),
    );
  }

  Widget _buildQuiz() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: screenHeight / 2.8,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 95, 117, 1),
                ),
                child: WaveWidget(
                  config: CustomConfig(
                    colors: [
                      const Color.fromARGB(143, 221, 226, 232),
                      const Color.fromARGB(104, 221, 226, 232),
                    ],
                    durations: [
                      9200,
                      7100,
                    ],
                    heightPercentages: [
                      0.85,
                      0.80,
                    ],
                  ),
                  size: const Size(double.infinity, 250),
                  waveAmplitude: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    quiz.questions[index]['question'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        optionButton(
            context,
            listOfOptions[0],
            quiz.questions[index]['options'][0],
            quiz.questions[index]['answer']),
        optionButton(
            context,
            listOfOptions[1],
            quiz.questions[index]['options'][1],
            quiz.questions[index]['answer']),
        optionButton(
            context,
            listOfOptions[2],
            quiz.questions[index]['options'][2],
            quiz.questions[index]['answer']),
        optionButton(
            context,
            listOfOptions[3],
            quiz.questions[index]['options'][3],
            quiz.questions[index]['answer']),
      ],
    );
  }

  Widget _buildLoading() {
    if (_hasInternet) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text("No internet connection"),
      );
    }

  }

  TextButton optionButton(BuildContext context, String optionLetter,
      String optionStatement, String correctAnswer) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(0, 95, 117, 1),
        ),
      ),
      onPressed: () {
        optionButtonPressed(context, optionStatement, correctAnswer,
            widget.name, widget.pincode);
        if (index == quizLength - 1) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return QuizEnd(name: name, pincode: pincode);
          }));
        } else {
          setState(() {
            index++;
          });
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 50,
                height: 65,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 95, 117, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      optionLetter,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  optionStatement,
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 95, 117, 1),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleError(e) {
    if (e.toString() == "Exception: 404") {
      // Handle not existing quiz
    } else if (e.toString() == "Exception: 204") {
      // Handle not opened quiz
    }
  }
}
