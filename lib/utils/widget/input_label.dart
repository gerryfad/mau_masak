import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  const InputLabel(
      {Key? key,
      required this.child,
      required this.label,
      this.separateHeight = 8})
      : super(key: key);

  final double? separateHeight;
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          child
        ],
      ),
    );
  }
}
