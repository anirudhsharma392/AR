import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';

class DefaultButton extends StatelessWidget {
  final Function onPress;
  final String name;
  final double height;
  final double width;
  final double fontSize;
  DefaultButton({this.onPress, this.name, this.width = 200, this.height = 70,this.fontSize=24});
  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.OnlyScale,
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 13.0,
              color: Colors.black.withOpacity(.5),
              offset: Offset(6.0, 7.0),
            ),
          ],
          color: Colors.redAccent,
        ),
        child: Center(
          child: Text(name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontWeight: FontWeight.w700,
fontSize: fontSize
              )),
        ),
      ),
      onTapDown: (_) {
        onPress();
      },
    );
  }
}
