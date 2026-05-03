import 'package:flutter/material.dart';

class Payment {
  final String id;
  final String title;
  final String subtitle;
  final Icon icon;

  const Payment({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
