import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Button extends StatelessWidget {

  final GestureTapCallback onPressed;
  final String text;
  final Color color;

  Button({@required this.onPressed, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color == null ?colorTheme1 : color ,
      splashColor: colorTheme2,
      onPressed: this.onPressed,
      child: new Text(
        text, 
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      shape: StadiumBorder(),
    );
  }
}