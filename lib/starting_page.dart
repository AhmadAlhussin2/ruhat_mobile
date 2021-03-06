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
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Wrap(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            formTitle(context),
                            const SizedBox(height: 10),
                            inputField(
                                context,
                                AppLocalizations.of(context)!.username,
                                nameController),
                            const SizedBox(height: 20),
                            inputField(
                                context,
                                AppLocalizations.of(context)!.pincode,
                                pincodeController),
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


  Text formTitle(BuildContext context) {
    return Text(
      "Ruhat",
      style: TextStyle(
        fontSize: 50,
        fontFamily: 'shago',
        color: Theme.of(context).focusColor,
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextButton enterButton(context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).highlightColor,
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
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }

  SizedBox inputField(
      BuildContext context, String hint, TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: TextFormField(
        autofocus: false,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: Theme.of(context).focusColor,
        style:  TextStyle(
          color: Theme.of(context).focusColor,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).secondaryHeaderColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          hintStyle: TextStyle(
            color: Theme.of(context).hintColor,
          ),
          hintText: hint,
        ),
      ),
    );
  }

}
