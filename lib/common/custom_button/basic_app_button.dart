import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatefulWidget {
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
  State<BasicAppButton> createState() => _BasicAppButtonState();
}

class _BasicAppButtonState extends State<BasicAppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(widget.height ?? 80),
          foregroundColor: Colors.white,
          fixedSize: Size.fromWidth(widget.width ?? double.infinity)),
      child: Text(widget.title),
    );
  }
}
