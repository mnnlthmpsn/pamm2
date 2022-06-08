import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pamm2/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewBuilder extends StatefulWidget {
  final String url;

  const WebViewBuilder({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewBuilder> createState() => _WebViewBuilderState();
}

class _WebViewBuilderState extends State<WebViewBuilder> {
  var loadingPercentage = 0;
  WebViewController? controller;
  bool back = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.url,
          zoomEnabled: false,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            controller = webViewController;
          },
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
        if (loadingPercentage < 100)
          Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          )
      ],
    );
  }
}
