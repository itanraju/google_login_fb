import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'login_controller.dart';

class MainScreenView extends GetView<LoginController> {
  var data=Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 16, right: 16),
          child: Text(data[0]+"  "+data[1],),
        ),
      ),
    );
  }
}
