import 'package:flutter/material.dart';

class AppProgress extends StatelessWidget {
  final double? size;
  final double? strokeWidth;
  final Color? color;

  const AppProgress({this.size, this.color, this.strokeWidth, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 24,
        height: size ?? 24,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 1,
          color: color ?? Colors.blue,
        ),
      ),
    );
  }
}
