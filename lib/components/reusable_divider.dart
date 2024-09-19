import 'package:flutter/material.dart';

Widget reusableDivider({
  double? height,
  double? indent,
  double? endIndent,
  double? thickness,
  Color? color,
  String? textInBetween,
}) {
  final Divider divider = Divider(
    indent: indent ?? 8.0,
    endIndent: endIndent ?? 8.0,
    height: height ?? 8.0,
    color: Colors.teal.shade100,
    thickness: thickness,
  );
  return textInBetween != null
      ? SizedBox(
          height: height,
          child: Row(
            children: [
              Expanded(
                child: divider,
              ),
              Text(
                textInBetween,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: divider,
              ),
            ],
          ),
        )
      : divider;
}
