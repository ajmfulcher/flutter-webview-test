import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: StackedWebView("https://www.bbc.co.uk/teach")
    );
  }
}

class StackedWebView extends StatefulWidget {
  final String url;

  StackedWebView(this.url) : super(key: UniqueKey());

  @override
  _StackedWebViewState createState() => _StackedWebViewState(this.url);
}

class _StackedWebViewState extends State<StackedWebView> {

  final String url;

  _StackedWebViewState(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(url),
            centerTitle: true
        ),
        bottomNavigationBar: SizedBox(
          height: 1,
          width: 1,
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) async {
            if (request.url == url || request.isForMainFrame == false) return NavigationDecision.navigate;
            return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StackedWebView(request.url))
            );
          },
          gestureNavigationEnabled: true
        )
    );
  }

}
