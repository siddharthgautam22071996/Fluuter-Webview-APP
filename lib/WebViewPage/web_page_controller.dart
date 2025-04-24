import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebPageController extends GetxController {
  late InAppWebViewController webViewController;
  late InAppWebViewGroupOptions options;

  late PullToRefreshController pullToRefreshController;
  String url = "";
  String title = "";
  double progress = 1.0;
  late URLRequest urlRequest;
  Map? postParam;
  String? thankyouUrl;

  int showAds = 0;

  @override
  void onInit() {
    super.onInit();
    getArguments();
  }

  void initData() {
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Get.theme.primaryColor,
      ),
      onRefresh: () async {
        webViewController.loadUrl(urlRequest: urlRequest);
      },
    );
    options = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ));

    if (postParam != null) {
      urlRequest = URLRequest(
        url: Uri.parse(url),
        method: 'POST',
        body: Uint8List.fromList(utf8.encode(jsonEncode(postParam))),
        // headers: {'Content-Type': 'application/json'},
      );
    } else {
      urlRequest = URLRequest(url: Uri.parse(url));
    }
    1.delay(() {
      pullToRefreshController.onRefresh!();
    });
  }

  void onConsoleMessage(
      InAppWebViewController controller, ConsoleMessage consoleMessage) {
    // Get.log('console message webview ::  ${consoleMessage.message}');
    // db.LocalStorage.instance
    //     .showSnackBar(S.current.error, '${consoleMessage.message}');
  }

  void onWebViewCreated(InAppWebViewController webViewCont) {
    webViewController = webViewCont;
    update();
  }

  void onProgressChanged(InAppWebViewController controller, int pro) {
    if (pro == 100) {
      pullToRefreshController.endRefreshing();
    }
    progress = pro / 100;
    update();
  }

  void getArguments() {
    if (Get.arguments != null) {
      Get.log('arguments webview :: ${Get.arguments}');
      title = Get.arguments['title'] ?? '';
      url = Get.arguments['url'] ?? 'https://dev.restrohub.com/checkout';
      if (Get.arguments['post_params'] != null) {
        postParam = Get.arguments['post_params'];
      }
      if (Get.arguments['thankyou_url'] != null) {
        thankyouUrl = Get.arguments['thankyou_url'];
      }
      thankyouUrl = 'https://dev.restrohub.com/checkout/order-confirmation/';
    }
    initData();
  }

  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    var uri = navigationAction.request.url;
    // Get.log('uris afkj $uri');
    // if (thankyouUrl.isNotEmpty && uri.toString() == thankyouUrl) {
    //   onOrderSuccess();
    //   return NavigationActionPolicy.CANCEL;
    // } else {
    return NavigationActionPolicy.ALLOW;
    // }
  }

  void onLoadStart(InAppWebViewController controller, Uri? url) {
    if (showAds < 2) {
      showAds++;
      update();
    } else {
      Get.log('gpoin to show');
    }
    Get.log('load start $url');
  }

  void onLoadStop(InAppWebViewController controller, Uri? url) {
    pullToRefreshController.endRefreshing();
    update();
  }

  void onLoadError(
      InAppWebViewController controller, Uri? url, int code, String message) {
    Get.log('console message ERROR webview ::  $message');
    pullToRefreshController.endRefreshing();
    Get.back();
  }

  Future<bool> onWillPop() async {
    var goBack = await webViewController.canGoBack();
    if (goBack == true) {
      webViewController.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
