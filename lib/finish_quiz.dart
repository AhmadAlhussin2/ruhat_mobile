import 'package:flutter/material.dart';
import 'package:ruhat/logic.dart';
import 'package:ruhat/models.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

class QuizEnd extends StatefulWidget {
  final String name;
  final String pincode;

  const QuizEnd({Key? key, required this.name, required this.pincode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizEndState();
}

class _QuizEndState extends State<QuizEnd> {
  // State
  bool _isLoading = false;
  bool _hasInternet = true;
  var count;
  var percentage;
  dynamic result;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    checkNetwork().then((connection){
      setState((){
        _hasInternet=connection;
      });
      if (_hasInternet) {
        getResult(widget.name, widget.pincode).then((data) {
          setState(() {
            _isLoading = false;
          });
          result = data;
          count = result['correct_answers'];
          percentage = result['percentage'];
        });
      }
    });

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
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: _isLoading ? _buildLoading() : _buildBody(),
      ),
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

  Widget _buildBody() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.white,
                Colors.purple
              ],
              createParticlePath: drawStar,
            )),
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
