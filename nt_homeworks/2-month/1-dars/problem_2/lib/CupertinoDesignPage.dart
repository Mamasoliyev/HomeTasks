import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDesignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Welcome')),
        child: Center(
          child: Text(
            'Flutter makes app development fun',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
