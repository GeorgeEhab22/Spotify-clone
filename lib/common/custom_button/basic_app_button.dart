import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 80),
          foregroundColor: Colors.white,
          fixedSize: Size.fromWidth(width ?? double.infinity)),
      child: Text(title),
    );
  }
}
