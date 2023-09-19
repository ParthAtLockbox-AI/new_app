import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AuthenticationViewModel extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController organizationController = TextEditingController();

  /// FOR ADD DONE BUTTON IN IOS KEYBOARD
  final mobileFocus = FocusNode();
  KeyboardActionsConfig buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Color(0xffd1d4dc),
      actions: [
        KeyboardActionsItem(focusNode: mobileFocus),
      ],
    );
  }

  /// FOR HOVER IN WEB
  bool forgotPasswordHover = false;
  updatePasswordHover(bool val) {
    forgotPasswordHover = val;
    update();
  }

  clearValue() {
    emailController.clear();
    mobileController.clear();
    otpController.clear();
    passwordController.clear();
    organizationController.clear();
  }
}
