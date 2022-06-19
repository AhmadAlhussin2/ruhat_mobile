import 'package:flutter/material.dart';
import 'package:ruhat/api.dart';
import 'package:ruhat/models.dart';


class QuizEnd extends StatelessWidget {
  final name;
  final pincode;
  const QuizEnd({Key? key, this.name, this.pincode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExitForm(name: name,pincode: pincode),
    );
  }
}

class ExitForm extends StatefulWidget {
  final name;
  final pincode;
  const ExitForm({Key? key, this.name, this.pincode}) : super(key: key);

  @override
  State<ExitForm> createState() => _ExitFormState();
}

class _ExitFormState extends State<ExitForm> {
  var index = 0;
  var quizLength = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: FutureBuilder(
        future: getResult(widget.name,widget.pincode),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          var count = 0;
          var percentage = 0.0;
          if (snapshot.hasData){
            count =snapshot.data?['correct_answers'];
            percentage = snapshot.data?['percentage'];
          }
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
                        'You have answered $count questions correctly!',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: screenHeight / 2.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'You are better than $percentage% of participants!',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(0, 95, 117, 1),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              returnButton(),
            ],
          );
        },
      ),
    );
  }

  TextButton returnButton() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 95, 117, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'RETURN',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}
