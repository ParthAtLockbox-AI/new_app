import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/const/common_snackbar.dart';
import 'package:ipapi/router/routers.dart';
import 'package:ipapi/view/ChatInterface/authentication/authentication_screen.dart';
import 'package:ipapi/view_model/authentication_view_model.dart';

class CreateOrganizationScreen extends StatefulWidget {
  const CreateOrganizationScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrganizationScreen> createState() =>
      _CreateOrganizationScreenState();
}

class _CreateOrganizationScreenState extends State<CreateOrganizationScreen> {
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
                            'Create Organization',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 65,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                          textEditingController:
                              controller.organizationController,
                          hintText: 'Organization Name',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
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
                              if (controller
                                  .organizationController.text.isEmpty) {
                                CommonSnackBar.getWarningSnackBar(
                                    context, 'Please enter organization name');
                              } else {
                                context.go(AppRout.homeScreen);
                              }
                            },
                            child: Text(
                              'Create Organization',
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
                              onTap: () {},
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
