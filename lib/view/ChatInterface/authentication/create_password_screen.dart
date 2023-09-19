import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/const/common_snackbar.dart';
import 'package:ipapi/router/routers.dart';
import 'package:ipapi/view/ChatInterface/authentication/authentication_screen.dart';
import 'package:ipapi/view_model/authentication_view_model.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  AuthenticationViewModel authenticationViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
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
                            'Create Password',
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
                          autofill: [AutofillHints.email],
                          textEditingController: controller.passwordController,
                          hintText: 'Enter Password',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
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
                              if (controller.passwordController.text.isEmpty) {
                                CommonSnackBar.getWarningSnackBar(
                                    context, 'Please enter password');
                              } else {
                                GoRouter.of(context)
                                    .goNamed(AppRout.mobileVerificationScreen);
                              }
                            },
                            child: Text(
                              'Save Password',
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
