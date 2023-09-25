import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  const Txt({
    Key? key,
    this.title = "",
    this.fontMaxLines = 5,
    this.textOverflow = TextOverflow.ellipsis,
    this.fontContainerWidth = 100,
    this.fontContainerColor = Colors.white,
    this.colorOpacity = 0.0,
    this.textAlign = TextAlign.center,
    this.textStyle,
  }) : super(key: key);

  final String title;
  final TextStyle? textStyle;
  final int fontMaxLines;
  final TextOverflow textOverflow;
  final double fontContainerWidth;
  final Color fontContainerColor;
  final double colorOpacity;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fontContainerWidth,
      color: fontContainerColor.withOpacity(colorOpacity),
      child: Text(
        title,
        style: textStyle,
        maxLines: fontMaxLines,
        overflow: textOverflow,
        textAlign: textAlign,
      ),
    );
  }
}
