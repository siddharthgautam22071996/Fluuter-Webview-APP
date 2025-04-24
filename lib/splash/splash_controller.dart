import 'package:blablastay_guest_web_app/WebViewPage/common_web_page.dart';
import 'package:blablastay_guest_web_app/fclone_constants.dart';
import 'package:get/get.dart';

import '../main.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 3));
    Get.offAll(() => const CommonWebPage(), arguments: {
      'url': FcloneConstants.url,
    });
  }
}
