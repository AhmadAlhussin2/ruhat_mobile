import 'package:flutter/material.dart';
import 'package:ruhat/api.dart';
import 'package:ruhat/models.dart';


import 'finish_quiz.dart';


class QuizPage extends StatelessWidget {
  final name;
  final pincode;
  QuizPage({Key? key, this.name, this.pincode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuizForm(name: name,pincode: pincode),
    );
  }
}

class QuizForm extends StatefulWidget {
  final name;
  final pincode;
  QuizForm({Key? key, this.name, this.pincode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final listOfOptions = ["A", "B", "C", "D"];
  late Future<Quiz> _dataFuture;
  var index = 0;
  var quizLength = 0;
  var name;
  var pincode;

  @override
  void initState() {
    super.initState();
    // print(widget.name);
    _dataFuture = getQuiz(widget.name, widget.pincode).catchError(handleError);
    name = widget.name;
    pincode = widget.pincode;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: FutureBuilder<Quiz>(
        future: _dataFuture,
        // initialData: Quiz.fromJson("Null"),
        builder: (BuildContext context, AsyncSnapshot<Quiz> snapshot) {
          if (snapshot.hasData) {
            quizLength = (snapshot.data as Quiz).questions.length;
            return Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: screenHeight / 2.8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 95, 117, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(screenWidth / 2, 40),
                        bottomRight: Radius.elliptical(screenWidth / 2, 40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          (snapshot.data as Quiz).questions[index]['question'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                optionButton(
                    context,
                    listOfOptions[0],
                    (snapshot.data as Quiz).questions[index]['options'][0],
                    (snapshot.data as Quiz).questions[index]['answer']),
                optionButton(
                    context,
                    listOfOptions[1],
                    (snapshot.data as Quiz).questions[index]['options'][1],
                    (snapshot.data as Quiz).questions[index]['answer']),
                optionButton(
                    context,
                    listOfOptions[2],
                    (snapshot.data as Quiz).questions[index]['options'][2],
                    (snapshot.data as Quiz).questions[index]['answer']),
                optionButton(
                    context,
                    listOfOptions[3],
                    (snapshot.data as Quiz).questions[index]['options'][3],
                    (snapshot.data as Quiz).questions[index]['answer']),
              ],
            );
          } else {
            // TODO: There should be a loading screen for a quiz
            return const Text("Debug");
          }
        },
      ),
    );
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
        postAnswer(optionStatement, correctAnswer,widget.name,widget.pincode);
        index++;
        // if index is equal to length of a quiz => go to the result page
        if (index==quizLength){
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){

              return QuizEnd(name: name, pincode: pincode);
            }),
          );
        } else {
          setState(() {});
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
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
                      style: const TextStyle(
                        color: Colors.white,
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
    if (e.toString()=="Exception: 404"){
      // Handle not existing quiz
    } else if (e.toString()=="Expection: 204"){
      // Handle not opened quiz
    }

  }
}
