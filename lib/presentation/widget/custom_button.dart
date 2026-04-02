import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double width;
  final Color backgroundColor;
  final Color? textColor;
  final bool borderRadius;
  final Color? borderColor;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.action,
    required this.text,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w600,
    this.width = double.infinity,
    this.backgroundColor = const Color.from(
      alpha: 0.8,
      red: 0.012,
      green: 0.663,
      blue: 0.957,
    ),
    this.textColor,
    this.borderRadius = true,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      borderRadius: borderRadius ? BorderRadius.circular(8) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ? BorderRadius.circular(8) : null,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
