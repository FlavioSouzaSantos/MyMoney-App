import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showCustomDialog({required BuildContext context, required String title, required String message, Function? okFunction}) {  // set up the button
  Widget okButton = TextButton(
    child: Text(AppLocalizations.of(context)!.ok),
    onPressed: () {
      Navigator.of(context).pop();
      okFunction?.call();
    },
  );  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showQuestionDialog({required BuildContext context, required String message, Function? yesFunction, Function? noFunction}) {  // set up the button
  Widget yesButton = TextButton(
    child: Text(AppLocalizations.of(context)!.yes),
    onPressed: () {
      Navigator.of(context).pop(); // dismi
      yesFunction?.call();// ss dialog
    },
  );
  Widget noButton = TextButton(
    child: Text(AppLocalizations.of(context)!.no),
    onPressed: () {
      Navigator.of(context).pop();
      noFunction?.call();// dismiss dialog
    },
  );// set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(AppLocalizations.of(context)!.question),
    content: Text(message),
    actions: [
      yesButton,
      noButton
    ],
  );  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}