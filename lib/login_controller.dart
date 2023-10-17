import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;

  /* late GoogleSignIn googleSignIn;
  var isSignIn=false.obs;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;*/
  final data = GetStorage();
  bool isRememberMe = false;
  var email = '';
  var password = '';
  var isPasswordHidden = true.obs;
  var isRememberMeChecked = true.obs;
  var isUserLogin = true.obs;
  var sEmail = "";
  var sPassword = "";

  @override
  void onInit() {
    super.onInit();

    if (data.read("isUserLogin") != null) {
      isUserLogin = data.read("isUserLogin");
      if(isUserLogin.value)
        {
          Get.offNamed("/mail",arguments: [data.read("name"),data.read("email")]);
        }

    } else {
      Get.offAll("/login");
    }

    if (data.read("isRememberMe") != null) {
      isRememberMe = data.read("isRememberMe");
    } else {
      data.writeIfNull("isRememberMe", false);
    }
    if (data.read("email") != null) {
      sEmail = data.read("email");
    }
    if (data.read("password") != null) {
      sPassword = data.read("password");
    }

    print("Existed email is $sEmail");

    if (isRememberMe) {
      emailController = TextEditingController(text: sEmail);
      passwordController = TextEditingController(text: sPassword);
    } else {
      emailController = TextEditingController();
      passwordController = TextEditingController();
    }
  }

  @override
  void onReady() async {
    /* googleSignIn=GoogleSignIn();
    ever(isSignIn,handleAuthStateChanged);
    isSignIn.value= await firebaseAuth.currentUser!=null;
    firebaseAuth.authStateChanges().listen((event) {
     isSignIn.value=event!=null;
    });*/
    super.onReady();
  }

  /*void handleAuthStateChanged(isLoggedIn){
      if(isLoggedIn)
        {
           Get.offAll(Routes.Main,arguments: firebaseAuth.currentUser);
        }
      else
        {
          Get.offAll(Routes.Login);
        }
   }
*/
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 8 characters";
    }
    return null;
  }

  bool checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      loginFormKey.currentState!.save();
      return true;
    }
  }

  void saveCradential(email, password) {
    data.write("isRememberMe", true);
    data.write("email", email);
    data.write("password", password);
  }

  void saveUserInfo(name, email) {
    data.write("isUserLogin", true);
    data.write("name", name);
    data.write("email", email);
  }
}
