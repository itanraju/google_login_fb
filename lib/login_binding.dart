import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:round_test_one/login_controller.dart';
import 'package:round_test_one/main_controller.dart';
import 'package:round_test_one/main_screen.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );

    Get.lazyPut<MainController>(
          () => MainController(),
    );
  }
}