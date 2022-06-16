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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(169, 192, 198, 1),
      body: Column(
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "What is the capital of Syria?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          optionButton(context, "A", "Damascus"),
          optionButton(context, "B", "Moscow"),
          optionButton(context, "C", "Dubai"),
          optionButton(context, "D", "Paris"),
        ],
      ),
    );
  }

  TextButton optionButton(
      BuildContext context, String optionLetter, String optionStatement) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(0, 95, 117, 1),
        ),
      ),
      onPressed: () {},
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
}
