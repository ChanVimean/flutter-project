import 'package:flutter/material.dart';

class CustomBento3Layout extends StatelessWidget {
  final Widget topLeft;
  final Widget bottomLeft;
  final Widget rightLarge;
  final double spacing;
  final double borderRadius;
  final bool reverse;

  const CustomBento3Layout({
    super.key,
    required this.topLeft,
    required this.bottomLeft,
    required this.rightLarge,
    this.spacing = 16.0,
    this.borderRadius = 24.0,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double s = (constraints.maxWidth - (2 * spacing)) / 3;
        final double largeSize = (2 * s) + spacing;
        final List<Widget> children = [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSlot(topLeft, s, s),
              SizedBox(height: spacing),
              _buildSlot(bottomLeft, s, s),
            ],
          ),
          _buildSlot(rightLarge, largeSize, largeSize),
        ];
        return Row(
          spacing: spacing,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: reverse ? children.reversed.toList() : children,
        );
      },
    );
  }

  Widget _buildSlot(Widget child, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}
