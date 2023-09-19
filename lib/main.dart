import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/controller_binding.dart';
import 'package:ipapi/router/routers.dart';

// / GO ROUTER WITH BOTTOM BAR
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp.router(
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
        routerDelegate: goRouter.routerDelegate,
        initialBinding: ControllerBindings(),
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColors.primary,
              ),
          scaffoldBackgroundColor: AppColors.backgroundColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: AppColors.neutralDarkGray,
                fontFamily: 'Roboto',
              ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   usePathUrlStrategy();
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         var currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus &&
//             currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus!.unfocus();
//         }
//       },
//       child: GetMaterialApp(
//         scrollBehavior: MaterialScrollBehavior().copyWith(
//           dragDevices: {
//             PointerDeviceKind.mouse,
//             PointerDeviceKind.touch,
//             PointerDeviceKind.stylus,
//             PointerDeviceKind.unknown
//           },
//         ),
//         initialBinding: ControllerBindings(),
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: Theme.of(context).copyWith(
//           colorScheme: Theme.of(context).colorScheme.copyWith(
//                 primary: AppColors.primary,
//               ),
//           scaffoldBackgroundColor: AppColors.backgroundColor,
//           textTheme: Theme.of(context).textTheme.apply(
//                 bodyColor: AppColors.neutralDarkGray,
//                 fontFamily: 'Roboto',
//               ),
//         ),
//         home: AuthenticationScreen(),
//       ),
//     );
//   }
// }
