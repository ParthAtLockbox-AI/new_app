import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackBar {
  static Duration duration = Duration(seconds: 5);
  static getSuccessSnackBar(BuildContext context, String message) {
    GetPlatform.isMobile
        ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green,
              duration: duration,
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
              width: Get.width - 34,
              closeIconColor: Colors.white,
            ),
          )
        : AnimatedSnackBar.rectangle(
            'Successfully',
            '$message',
            duration: duration,
            desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
            type: AnimatedSnackBarType.success,
            brightness: Brightness.dark,
          ).show(
            context,
          );
  }

  static getFailedSnackBar(BuildContext context, String message) {
    GetPlatform.isMobile
        ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
              duration: duration,
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
              width: Get.width - 34,
              closeIconColor: Colors.white,
            ),
          )
        : AnimatedSnackBar.rectangle(
            'Failed',
            '$message',
            duration: duration,
            desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
            type: AnimatedSnackBarType.error,
            brightness: Brightness.dark,
          ).show(
            context,
          );
  }

  static getWarningSnackBar(BuildContext context, String message) {
    GetPlatform.isMobile
        ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
              duration: duration,
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              width: Get.width - 34,
            ),
          )
        : AnimatedSnackBar.rectangle(
            'Warning',
            '$message',
            duration: duration,
            desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
            type: AnimatedSnackBarType.warning,
            brightness: Brightness.dark,
          ).show(
            context,
          );
  }
}
