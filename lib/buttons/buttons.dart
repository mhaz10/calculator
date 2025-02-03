import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Color? color;
  final Color? textColor;
  final String? buttonText;
  final GestureTapCallback? buttonTapped;


  const MyButton({super.key, this.color, this.textColor, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            buttonText!,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
