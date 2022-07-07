import 'package:flutter/material.dart';
import 'package:ruhat/logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EnterQuiz extends StatelessWidget {
  EnterQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Center(
              child: Wrap(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            formTitle(),
                            const SizedBox(height: 10),
                            inputField(context, AppLocalizations.of(context)!.username, nameController),
                            const SizedBox(height: 20),
                            inputField(context, AppLocalizations.of(context)!.pincode, pincodeController),
                            const SizedBox(height: 20),
                            enterButton(context),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Text formTitle() {
    return const Text(
      "Ruhat",
      style: TextStyle(
        fontSize: 50,
        fontFamily: 'shago',
        color: Color.fromRGBO(0, 95, 117, 1),
      ),
    );
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextButton enterButton(context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 95, 117, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
      ),
      onPressed: () {
        enterButtonPressed(nameController.text,pincodeController.text, context);
      },
      child: Text(
        AppLocalizations.of(context)!.enter,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }

  SizedBox inputField(BuildContext context, String hint, TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: TextFormField(
        autofocus: false,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: const Color.fromRGBO(0, 95, 117, 1),
        style: const TextStyle(
          color: Color.fromRGBO(0, 95, 117, 1),
          fontSize: 20,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(221, 226, 232, 1),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(221, 226, 232, 1),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(221, 226, 232, 1),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(221, 226, 232, 1),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          hintStyle: const TextStyle(
            color: Color.fromRGBO(169, 192, 198, 1),
          ),
          hintText: hint,
        ),
      ),
    );
  }

}
