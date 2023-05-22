import 'package:flutter/material.dart';
import 'package:caffe_app_user/utility/constants.dart';

class CircleIconButton extends StatelessWidget {
  final Function onPress;
  final Color buttonColor;
  final Color pressColor;
  final Color iconColor;
  final IconData iconData;

  const CircleIconButton(
      {super.key,
      required this.onPress,
      this.buttonColor = primaryColor,
      this.pressColor = subColor2,
      this.iconColor = secondaryColor,
      this.iconData = Icons.arrow_forward_ios_rounded});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPress(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
        backgroundColor: MaterialStateProperty.all(buttonColor),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return pressColor;
          }
          return null;
        }),
      ),
      child: Icon(
        iconData,
        color: secondaryColor,
      ),
    );
  }
}
