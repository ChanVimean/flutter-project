import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  final bool filled;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextfield({
    super.key,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.isPassword = false,
    this.filled = true,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<CustomTextfield> createState() => _InputFieldState();
}

class _InputFieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: widget.labelText.isEmpty ? null : widget.labelText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: theme.colorScheme.primary.withValues(alpha: 0.7),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: theme.colorScheme.outline,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : null,
        hintText: widget.hintText,
        filled: widget.filled,
        fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.2,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        hintStyle: TextStyle(
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        labelStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
