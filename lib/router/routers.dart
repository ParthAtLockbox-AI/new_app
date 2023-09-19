import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipapi/view/ChatInterface/authentication/authentication_screen.dart';
import 'package:ipapi/view/ChatInterface/authentication/create_organizatiopn_screen.dart';
import 'package:ipapi/view/ChatInterface/authentication/create_password_screen.dart';
import 'package:ipapi/view/ChatInterface/authentication/enter_password_screen.dart';
import 'package:ipapi/view/ChatInterface/authentication/mobile_verification_screen.dart';
import 'package:ipapi/view/ChatInterface/authentication/verification_code_screen.dart';
import 'package:ipapi/view/ChatInterface/bottom_bar.dart';
import 'package:ipapi/view/ChatInterface/call_screen.dart';
import 'package:ipapi/view/ChatInterface/history_screen.dart';
import 'package:ipapi/view/ChatInterface/home_screen/home_screen.dart';

class AppRout {
  static const String callScreen = '/callScreen';
  static const String homeScreen = '/homeScreen';
  static const String historyScreen = '/historyScreen';
  static const String authenticationScreen = '/authentication';
  static const String mobileVerificationScreen = '/mobileVerification';
  static const String verificationCodeScreen = '/verificationCode';
  static const String createPasswordScreen = '/createPassword';
  static const String enterPasswordScreen = '/password';
  static const String createOrganizationScreen = '/createOrganization';
}

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorCallKey = GlobalKey<NavigatorState>(debugLabel: 'Call');
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
final _shellNavigatorHistoryKey =
    GlobalKey<NavigatorState>(debugLabel: 'History');

final goRouter = GoRouter(
  initialLocation: AppRout.authenticationScreen,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return null;
  },
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRout.authenticationScreen,
      name: AppRout.authenticationScreen,
      pageBuilder: (context, state) => NoTransitionPage(
        child: AuthenticationScreen(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRout.mobileVerificationScreen,
      name: AppRout.mobileVerificationScreen,
      pageBuilder: (context, state) => NoTransitionPage(
        child: MobileVerificationScreen(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRout.createPasswordScreen,
      name: AppRout.createPasswordScreen,
      pageBuilder: (context, state) => NoTransitionPage(
        child: CreatePasswordScreen(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRout.verificationCodeScreen,
      name: AppRout.verificationCodeScreen,
      pageBuilder: (context, state) => NoTransitionPage(
        child: VerificationCodeScreen(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRout.enterPasswordScreen,
      name: AppRout.enterPasswordScreen,
      pageBuilder: (context, state) => NoTransitionPage(
        child: EnterPasswordScreen(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRout.createOrganizationScreen,
      name: AppRout.createOrganizationScreen,
      pageBuilder: (context, state) => NoTransitionPage(
        child: CreateOrganizationScreen(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomBarScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: AppRout.homeScreen,
              pageBuilder: (context, state) => NoTransitionPage(
                child: HomeScreen(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCallKey,
          routes: [
            GoRoute(
              path: AppRout.callScreen,
              pageBuilder: (context, state) => NoTransitionPage(
                child: CallScreen(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHistoryKey,
          routes: [
            GoRoute(
              path: AppRout.historyScreen,
              pageBuilder: (context, state) => NoTransitionPage(
                child: HistoryScreen(),
              ),
              routes: [],
            ),
          ],
        ),
      ],
    ),
  ],
);
