import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonPadrao extends StatelessWidget {
  final String value;
  final Function() onTap;
  final Color colorsButton;
  final Color colorsText;
  const ButtonPadrao(
      {Key key, this.value, this.onTap, this.colorsButton, this.colorsText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      child: RaisedButton(
        disabledColor: Colors.blue[200],
        color: colorsButton,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30),
          side: BorderSide(
            color: Color(0xff00acee),
          ),
        ),
        child: Text(
          "$value",
          style: GoogleFonts.rubik(color: colorsText, fontSize: 18),
        ),
        onPressed: onTap,
      ),
    );
  }
}
