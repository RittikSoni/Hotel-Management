import 'package:flutter/material.dart';

class Commonfunctions {
  /// Default `gapMultiplier = 1.0`,
  /// Default `gap = 20.0`,
  /// Default is vertical Gapping
  static Widget gapMultiplier({bool? isHorizontal, double? gapMultiplier}) {
    if (isHorizontal == true) {
      return SizedBox(
        width: 20.0 * (gapMultiplier ?? 1.0),
      );
    }
    return SizedBox(
      height: 20.0 * (gapMultiplier ?? 1.0),
    );
  }
}
