import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      theme: ThemeData(primarySwatch: Colors.purple),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingController = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "https://google.com";
  launchUrl() {
    setState(() {
      urlString = textEditingController.text;
      flutterWebviewPlugin.reloadUrl(urlString);
    });
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => launchUrl(),
          )
        ],
        title: TextField(
          autofocus: false,
          controller: textEditingController,
          cursorColor: Colors.white,
          cursorWidth: 0.3,
          textInputAction: TextInputAction.go,
          onSubmitted: (url) => launchUrl(),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter URL",
              hintStyle: TextStyle(color: Colors.white)),
        ),
      ),
      url: urlString,
    );
  }
}
