import 'package:flutter/material.dart';
import 'package:lab5/utils/utils.dart';

class FullWithButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const FullWithButton({
    super.key,
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  backgroundColor: framesColor),
              onPressed: callback,
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontFamily: 'MontserratMedium',
                    fontWeight: FontWeight.w500),
              )),
        )
      ],
    );
  }
}
