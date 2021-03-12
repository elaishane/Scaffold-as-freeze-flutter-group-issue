import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _website = 'http://www.vodome.co/';

  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the App'),
        actions: [
          TextButton(
            onPressed: () async {
              await _launchInApp();
              exit(0);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _launchInApp() {
    if (canLaunch(_website) != null) {
      launch(
        _website,
        forceSafariVC: true,
        enableJavaScript: true,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
      // _onWillPop();
    } else {
      throw 'Could not launch $_website';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () async => await onWillPop(),
          ),
        ),
        body: Center(child: Text("Home Page")),
      ),
    );
  }
}
