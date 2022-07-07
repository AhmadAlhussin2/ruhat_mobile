import 'package:flutter/material.dart';
import 'package:ruhat/api.dart';
import 'package:ruhat/models.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

class QuizEnd extends StatelessWidget {
  final String name;
  final String pincode;
  const QuizEnd({Key? key, required this.name, required this.pincode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExitForm(name: name, pincode: pincode),
    );
  }
}

class ExitForm extends StatefulWidget {
  final String name;
  final String pincode;
  const ExitForm({Key? key, required this.name, required this.pincode})
      : super(key: key);

  @override
  State<ExitForm> createState() => _ExitFormState();
}

class _ExitFormState extends State<ExitForm> {
  var index = 0;
  var quizLength = 0;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));
        WidgetsBinding.instance
        .addPostFrameCallback((_) => _controllerCenter.play());
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  late ConfettiController _controllerCenter;
  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);
    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: FutureBuilder(
        future: getResult(widget.name, widget.pincode),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          var count = 0;
          var percentage = 0.0;
          if (snapshot.hasData) {
            count = snapshot.data?['correct_answers'];
            percentage = snapshot.data?['percentage'];
          }
          return Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.white,
                    Colors.purple
                  ], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),
              Column(
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
              ),
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
