import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/const/common_snackbar.dart';
import 'package:ipapi/router/routers.dart';
import 'package:ipapi/view/ChatInterface/authentication/authentication_screen.dart';
import 'package:ipapi/view_model/authentication_view_model.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class MobileVerificationScreen extends StatefulWidget {
  const MobileVerificationScreen({Key? key}) : super(key: key);

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  AuthenticationViewModel authenticationViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetPlatform.isIOS
          ? KeyboardActions(
              config:
                  authenticationViewModel.buildKeyboardActionsConfig(context),
              child: MobileVerificationWidget(context),
            )
          : MobileVerificationWidget(context),
    );
  }

  MobileVerificationWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 400,
              width: GetPlatform.isMobile ? Get.width : 350,
              padding: EdgeInsets.fromLTRB(24, 67, 24, 40),
              child: GetBuilder<AuthenticationViewModel>(
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Human Verification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 65,
                      ),
                      AuthTextField(
                        keyboardType: TextInputType.number,
                        focusNode: controller.mobileFocus,
                        textEditingController: controller.mobileController,
                        hintText: 'Enter phone number',
                        icon: CountryCodePicker(
                          onChanged: (value) {},
                          flagWidth: 25,
                          initialSelection: 'US',
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 40,
                        width: Get.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xff0099CC),
                          ),
                          onPressed: () {
                            if (controller.mobileController.text.isNotEmpty) {
                              if (controller.mobileController.text.length >
                                      10 ||
                                  controller.mobileController.text.length <
                                      10) {
                                CommonSnackBar.getWarningSnackBar(
                                    context, 'Please enter valid phone number');
                              } else {
                                GoRouter.of(context)
                                    .goNamed(AppRout.verificationCodeScreen);
                              }
                            } else {
                              CommonSnackBar.getWarningSnackBar(
                                  context, 'Please enter phone number');
                            }
                          },
                          child: Text(
                            'Send verification code',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.basicWhite,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: MouseRegion(
                          onEnter: (event) {
                            controller.updatePasswordHover(true);
                          },
                          onExit: (event) {
                            controller.updatePasswordHover(false);
                          },
                          child: GestureDetector(
                            onTap: () {
                              // GoRouter.of(context)
                              //     .goNamed(AppRout.forgotPasswordScreen);
                            },
                            child: Text(
                              'Talk to John',
                              style: TextStyle(
                                decoration:
                                    controller.forgotPasswordHover == true
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: controller.forgotPasswordHover == true
                                    ? Color(0xff0099CC)
                                    : Color(0xff0473F9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
