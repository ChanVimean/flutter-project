import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const CustomTextButton({
    super.key,
    required this.action,
    required this.text,
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
