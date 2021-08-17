import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webview extends StatefulWidget {
   Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  _webviewState createState() => _webviewState();
}
String urlwebview='https://www.google.com';
class _webviewState extends State<webview> {
  
  Completer<WebViewController> _controller = Completer<WebViewController>();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:urlwebview,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      
    );
  }

  
  }