import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

Future<bool> callPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.locationAlways,
    Permission.storage,
  ].request();

  if (statuses.values.every((element) => element.isGranted)) {
    return true;
  }

  return false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '권한을 주세요',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: callPermissions(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data) {
                 return WebViewExample();
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}


class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        body: WebView(
          initialUrl: 'https://blog.naver.com/cieldinoegg',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (_webViewController == null) {
      return true;
    }
    if (await _webViewController!.canGoBack()) {
      _webViewController!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}