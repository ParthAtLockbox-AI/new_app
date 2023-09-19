import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/const/common_snackbar.dart';
import 'package:ipapi/router/routers.dart';
import 'package:ipapi/view_model/authentication_view_model.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  AuthenticationViewModel authenticationViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: AppColors.basicBlack,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      ),
    );
    return Scaffold(
      body: Center(
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
                        Align(
                          alignment: Alignment.center,
                          child: Pinput(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            defaultPinTheme: defaultPinTheme,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (value) {
                              controller.otpController.text = value;
                            },
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
                              if (controller.otpController.text.isEmpty) {
                                CommonSnackBar.getWarningSnackBar(
                                    context, 'Please enter otp');
                              } else {
                                GoRouter.of(context)
                                    .goNamed(AppRout.createOrganizationScreen);
                              }
                            },
                            child: Text(
                              'Verify code',
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
      ),
    );
  }
}
