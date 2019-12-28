import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool _shouldRetry = false;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onHttpError.listen((httpError) {
      log(httpError.code);
      if (httpError != null) {
        _shouldRetry = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://app.farmoi.com',
      withZoom: false,
      displayZoomControls: false,
      hidden: true,
      initialChild: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_app.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RotateAnimatedTextKit(
                    text: [
                      'Mua rau sạch',
                      'trực tiếp từ vườn.',
                      'Nông trại bạn biết.',
                      'Nông dân bạn quen.',
                      'Sử dụng thực phẩm',
                      'khi bạn nắm rõ',
                      'quá trình sinh trưởng.'
                    ],
                    textStyle: TextStyle(
                      fontSize: 24.0,
                      color: Color.fromRGBO(3, 191, 130, 1.0),
                      fontWeight: FontWeight.bold,
                    ),
                    duration: Duration(milliseconds: 1600),
                    totalRepeatCount: 10,
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.center),
              ],
            ),
            _shouldRetry
                ? CupertinoButton(
                    onPressed: () {
                      _shouldRetry = false;
                      flutterWebviewPlugin.reload();
                    },
                    color: Color.fromRGBO(3, 191, 130, 1.0),
                    child: Text('Tải lại trang'),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
