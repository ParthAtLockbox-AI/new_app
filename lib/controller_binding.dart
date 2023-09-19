import 'package:get/get.dart';
import 'package:ipapi/view_model/authentication_view_model.dart';
import 'package:ipapi/view_model/home_view_model.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    /// controller that will not cleared from memory until app is live.
    Get.put<HomeViewModel>(
      HomeViewModel(),
      permanent: true,
    );
    Get.put<AuthenticationViewModel>(
      AuthenticationViewModel(),
      permanent: true,
    );
  }
}
