import 'package:animator/animator.dart';
import 'package:blablastay_guest_web_app/fclone_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  color: FcloneConstants.logoBackColor,
                  height: Get.height,
                  width: Get.width,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Animator<double>(
                        tween: Tween<double>(begin: 0.0, end: 150),
                        cycles: 0,
                        repeats: 1,
                        duration: const Duration(seconds: 1),
                        builder: (context, animatorState, child) {
                          return Hero(
                            tag: 'logoTag',
                            child: Image.asset(
                              FcloneConstants.logoFullTrans,
                              fit: BoxFit.cover,
                            ).paddingSymmetric(
                              horizontal: 50,
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
