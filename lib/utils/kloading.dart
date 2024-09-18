import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';

import 'package:hotel_management/utils/kroute.dart';

class KLoadingToast {
  static void startLoading() {
    BotToast.showCustomLoading(
      allowClick: false,
      crossPage: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder: (cancelFunc) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void stopLoading() {
    BotToast.closeAllLoading();
  }

  static void showToast({required String msg, int? durationInSeconds}) {
    BotToast.showText(
      text: msg,
      onlyOne: true,
      duration: Duration(seconds: durationInSeconds ?? 2),
      clickClose: true,
      crossPage: true,
      backButtonBehavior: BackButtonBehavior.none,
    );
  }

  static void showNotification({
    required String msg,
    int? durationInSeconds,
    bool? crossPage,
  }) {
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) {
        return Material(
          child: ListTile(
            title: Text(msg),
            trailing: IconButton(
              onPressed: () {
                cancelFunc.call();
              },
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        );
      },
      onlyOne: true,
      duration: Duration(seconds: durationInSeconds ?? 2),
      crossPage: crossPage ?? true,
      backButtonBehavior: BackButtonBehavior.none,
    );
  }

  static Future<void> showCustomDialog({
    required String message,
    bool? barrierDismissible,
    bool? canpop,
    String? buttonLabel,
    Function()? onTap,
  }) async {
    return await showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) {
        return PopScope(
          canPop: canpop ?? true,
          child: AlertDialog(
            title: Text(
              message,
            ),
            content: ElevatedButton(
              onPressed: onTap ??
                  () {
                    Navigator.pop(context);
                  },
              child: Text(buttonLabel ?? 'Ok'),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showDialogMultipleButtons({
    required String title,
    Widget? content,
    bool? barrierDismissible,
    bool? canpop,
    List<Widget>? widgets,
    MainAxisAlignment? mainAxisAlignment,
  }) async {
    return await showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) {
        return PopScope(
          canPop: canpop ?? true,
          child: AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            actions: [
              widgets != null
                  ? Row(
                      mainAxisAlignment:
                          mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
                      children: widgets,
                    )
                  : const SizedBox(),
            ],
            content: content,
          ),
        );
      },
    );
  }
}
