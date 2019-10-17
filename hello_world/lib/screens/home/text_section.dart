import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final Color _color;
  final String _text;

  TextSection( this._color, this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: this._color,),
          child: Text(this._text,
          textDirection: 
            TextDirection.ltr, 
            style: TextStyle(fontSize: 32, color: Colors.black, )),
 
      );

  }

}