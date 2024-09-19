import 'package:flutter/material.dart';
import 'package:hotel_management/components/reusable_button.dart';
import 'package:hotel_management/components/reusable_divider.dart';
import 'package:hotel_management/utils/kroute.dart';

/// A reusable Bottom Sheet component for displaying content in a bottom sheet.
class ReusableBottomSheet {
  /// Displays a reusable Bottom Sheet.
  ///
  /// [context] is the BuildContext where the bottom sheet should be displayed.
  ///
  /// [title] is the title widget displayed at the top.
  ///
  /// [content] is the main content of the bottom sheet. You can pass any widget.
  ///
  /// [isScrollControlled] specifies whether the content should be scrollable.
  ///
  /// [isDismissible] controls whether the user can dismiss the bottom sheet by tapping outside.
  ///
  /// [onWillPop] is a callback function that allows dynamic behavior when the back button is pressed.
  ///
  /// [borderRadius] specifies the corner radius for the top corners of the bottom sheet.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget title,
    required Widget content,
    String? primaryButtonLabel,
    bool isScrollControlled = false,
    bool isDismissible = true,
    Future<bool> Function()? onWillPop,
    BorderRadiusGeometry? borderRadius,
    VoidCallback? primaryButtonOnTap,
  }) {
    return showModalBottomSheet<T>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.hardEdge,
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            if (onWillPop != null) {
              final canPop = await onWillPop();
              if (!canPop) {
                return false; // Prevent the app from exiting
              }
            }

            Navigator.of(navigatorKey.currentContext!).pop();
            return false; // Prevent the app from exiting
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 1.7,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.zero,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: title, // Centered title widget
                  ),
                ),
                reusableDivider(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        // Divider line
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: content,
                        ),
                      ],
                    ),
                  ),
                ),
                primaryButtonLabel == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15.0, right: 8.0, left: 8.0),
                        child: ReusableButton(
                          label: primaryButtonLabel,
                          mainAxisAlignment: MainAxisAlignment.center,
                          onTap: primaryButtonOnTap,
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
