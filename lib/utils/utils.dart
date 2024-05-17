import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color primeColor = Colors.black;
Color secondaryColor = Colors.white;
Color additionalColor = const Color.fromARGB(255, 181, 174, 174);
Color linkColor = const Color(0xFF319FB7);
Color framesColor = const Color(0xFF302F2F);

SnackBar snackBar(
    String label, String content, VoidCallback callback, Color color) {
  return SnackBar(
    content: Text(
      content,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
    backgroundColor: (color),
    duration: const Duration(milliseconds: 1500),
    action: SnackBarAction(
      label: label,
      onPressed: callback,
    ),
  );
}

void showAlertDialog(
    {required BuildContext context,
    required String text,
    required VoidCallback callback,
    VoidCallback? backCallback,
    String pos = 'Yes',
    String neg = 'No'}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Alert'),
      content: Text(text),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            if (backCallback != null) {
              backCallback();
            }
            Navigator.pop(context);
          },
          child: Text(neg),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            callback();

            Navigator.pop(context);
          },
          child: Text(pos),
        ),
      ],
    ),
  );
}

void showDialogd(BuildContext context, Widget child) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: child,
            ),
          ));
}

void chooseCategory(BuildContext context, Widget child) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}
