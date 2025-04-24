import 'dart:collection';


import 'package:blablastay_guest_web_app/fclone_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'web_page_controller.dart';

class CommonWebPage extends StatelessWidget {
  const CommonWebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebPageController>(
        init: WebPageController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  toolbarHeight: 0.0,
                  backgroundColor: FcloneConstants.appBarColor,
                ),
                body: SafeArea(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.progress < 1.0)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Get.theme.primaryColor,
                          ),
                          value: controller.progress,
                        ),
                      ),
                    Expanded(
                      child: InAppWebView(
                          // contextMenu: contextMenu,
                          // initialUrlRequest:
                          // URLRequest(url: Uri.parse("https://github.com/flutter")),
                          // initialFile: "assets/index.html",
                          initialUrlRequest: controller.urlRequest,
                          initialUserScripts:
                              UnmodifiableListView<UserScript>([]),
                          initialOptions: controller.options,
                          pullToRefreshController:
                              controller.pullToRefreshController,
                          onWebViewCreated: controller.onWebViewCreated,
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            return PermissionRequestResponse(
                                resources: resources,
                                action: PermissionRequestResponseAction.GRANT);
                          },
                          shouldOverrideUrlLoading:
                              controller.shouldOverrideUrlLoading,
                          onLoadStart: controller.onLoadStart,
                          onLoadStop: controller.onLoadStop,
                          onLoadError: controller.onLoadError,
                          onProgressChanged: controller.onProgressChanged,
                          onConsoleMessage: controller.onConsoleMessage),
                    ),
                    // Get.find<FacebookAdsController>().currentAd,
                  ],
                ))),
          );
        });
  }
}
