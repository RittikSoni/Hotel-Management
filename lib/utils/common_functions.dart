import 'dart:math';
import 'package:intl/intl.dart';
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

  /// Format timestamp in `dd-MM-yyyy` format
  ///
  /// iso8601String like "2023-10-25T13:30:00Z"
  static String dateFormatterFromIso8601(String timestamp) {
    // Parse the ISO 8601 string to a DateTime object
    DateTime isoDate = DateTime.parse(timestamp).toLocal();

    // Format the date into "dd-MM-yyyy" format
    String formattedDate = DateFormat('dd-MM-yyyy').format(isoDate);

    return formattedDate;
  }
}
