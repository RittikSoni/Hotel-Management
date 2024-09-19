import 'dart:math';

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

  static String generateUniqueCode() {
    // Generate a random 6-digit number
    final String randomValue = (100000 + Random().nextInt(900000)).toString();

    // Get the current timestamp in milliseconds
    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    // Combine the timestamp and random number to create a unique code
    final String uniqueCode = '$timestamp$randomValue';

    return uniqueCode;
  }
}
