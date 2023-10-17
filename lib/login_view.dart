import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:round_test_one/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 16, right: 16),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Form(
              key: controller.loginFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome to Ripples Code",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    onSaved: (value) {
                      controller.email = value!;
                    },
                    validator: (value) {
                      return controller.validateEmail(value!);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(() =>                   TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffix: InkWell(
                        child: controller.isPasswordHidden.value?Icon(Icons.visibility_off):Icon(Icons.visibility),
                        onTap: () {
                          controller.isPasswordHidden.value =
                          !controller.isPasswordHidden.value;
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.isPasswordHidden.value,
                    controller: controller.passwordController,
                    onSaved: (value) {
                      controller.password = value!;
                    },
                    validator: (value) {
                      return controller.validatePassword(value!);
                    },
                  )),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() => CheckboxListTile(
                        title: const Text('Remember Me ?'),
                        subtitle: const Text('This will saved your credential'),
                        autofocus: false,
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        value: controller.isRememberMeChecked.value,
                        onChanged: (value) {
                          controller.isRememberMeChecked.value = value!;
                        },
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        if (controller.checkLogin()) {
                          if (controller.emailController.text ==
                                  "dev@demo.com" &&
                              controller.passwordController.text ==
                                  "Developer") {
                            if (controller.isRememberMeChecked.value) {
                                controller.saveCradential(controller.emailController.text, controller.passwordController.text);
                                controller.saveUserInfo(controller.passwordController.text,controller.emailController.text);
                                Get.offNamed("/main", arguments: [controller.passwordController.text,controller.emailController.text]);
                              Get.snackbar(
                                  "Good", "Congratulations Data Saved");
                            } else {
                              //controller.data.erase();
                              controller.saveUserInfo(controller.passwordController.text,controller.emailController.text);
                              Get.offNamed("/main", arguments: [controller.passwordController.text,controller.emailController.text]);
                            }
                          } else {
                            Get.snackbar("Incorrect", "User not found");
                          }
                        } else {
                          Get.snackbar("Sorry", "error");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurpleAccent),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Login With Google",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        signInWithGoogle();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth= await googleUser?.authentication;

    AuthCredential credential=GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    if(userCredential.user==null)
      {
          String? name=userCredential.user!.displayName;
          String? email=userCredential.user!.email;
          Get.offNamed("/main",arguments: [name,email]);
      }
    else
      {
        Get.snackbar("Sorry", "Something went wrong");
      }
  }
}
