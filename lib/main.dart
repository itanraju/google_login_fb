import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:round_test_one/login_binding.dart';
import 'package:round_test_one/login_view.dart';
import 'package:round_test_one/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: "login",
      getPages: [
        GetPage(name: "/login", page:()=>LoginView(),binding: LoginBinding()),
        GetPage(name: "/main", page:()=>MainScreenView(),binding: LoginBinding()),
      ],
      debugShowCheckedModeBanner: false,
    ),
  );
}
