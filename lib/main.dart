import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'fclone_constants.dart';
import 'splash/splash_screen.dart';
import 'utility/main_binding.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: FcloneConstants.appName,
      theme: ThemeData(
        primaryColor: FcloneConstants.color,
        colorScheme:  ColorScheme.light(
          primary: FcloneConstants.color,
        ),
      ),
      initialBinding: MainBinding(),
      enableLog: kDebugMode ? true : false,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      home: const SplashScreen(),
      routingCallback: (s) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }
}
