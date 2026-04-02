import 'package:flutter/material.dart';

// Usage Example:
// CustomText("Final Boss Figure", variant: TextVariant.h1),
// CustomText("Released in 2026", variant: TextVariant.muted),

// Text Varients Enumeration
enum TextVariant {
  /// **Primary Heading**
  /// The largest text, used for main page titles and hero sections.
  h1(fontSize: 24, fontWeight: FontWeight.bold, spacing: -0.5),

  /// **Section Heading**
  /// Used for major categories or content dividers.
  h2(fontSize: 20, fontWeight: FontWeight.w700),

  /// **Sub-heading**
  /// Ideal for product names in lists or card headers.
  h3(fontSize: 16, fontWeight: FontWeight.w600),

  /// **Standard Content**
  /// The base style for general readable text across the app.
  body(fontSize: 16, fontWeight: FontWeight.normal),

  /// **Metadata & Fine Print**
  /// Used for timestamps, legal text, or secondary annotations.
  big(fontSize: 32, fontWeight: FontWeight.bold),

  /// **Metadata & Fine Print**
  /// Used for timestamps, legal text, or secondary annotations.
  small(fontSize: 12, fontWeight: FontWeight.normal),

  /// **De-emphasized Text**
  /// Subtle styling for supplementary info or placeholders.
  muted(fontSize: 14, fontWeight: FontWeight.normal, colorOpacity: 0.8);

  final double fontSize;
  final FontWeight fontWeight;
  final double spacing;
  final double colorOpacity;

  const TextVariant({
    required this.fontSize,
    required this.fontWeight,
    this.spacing = 0.0,
    this.colorOpacity = 1.0,
  });
}

class CustomText extends StatelessWidget {
  final String text;
  final TextVariant textVariant;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;

  const CustomText(
    this.text, {
    super.key,
    this.textVariant = TextVariant.body,
    this.textAlign,
    this.color,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final Color themeTextColor = Theme.of(context).colorScheme.onSurface;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: textVariant.fontSize,
        fontWeight: textVariant.fontWeight,
        letterSpacing: textVariant.spacing,
        color:
            color ?? themeTextColor.withValues(alpha: textVariant.colorOpacity),
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
