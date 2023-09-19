import 'package:flutter/material.dart';
import 'package:ipapi/const/images.dart';
import 'package:lottie/lottie.dart';

Widget LottieAnimAnimation({double size = 100}) {
  return Lottie.asset(
    AppImages.loader,
    width: size,
    height: size/2,
    fit: BoxFit.fill,
  );
}
