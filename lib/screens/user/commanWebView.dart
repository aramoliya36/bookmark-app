import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommanWebView extends StatefulWidget {
  final String url;
  final String title;
  const CommanWebView({Key key, this.url, this.title}) : super(key: key);
  @override
  _CommanWebViewState createState() => _CommanWebViewState();
}

class _CommanWebViewState extends State<CommanWebView> {
  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: TextStyle(color: colorPalette.navyBlue, fontSize: 18.0),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorPalette.navyBlue,
            ),
          ),
        ),
        body: WebviewScaffold(
          url: widget.url,
          withLocalStorage: true,
          withJavascript: true,
          // javascriptMode: JavascriptMode.unrestricted,
        ),
        /*WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),*/
      ),
    );
  }
}
