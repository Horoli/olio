import 'package:flutter/material.dart';
import 'package:first/common.dart';

import 'common.dart';
import 'preset/router.dart' as ROUTER;

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  final Map<String, Widget Function(BuildContext)> routes = {
    ROUTER.HOME: (BuildContext context) => ViewHome()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ROUTER.HOME,
      routes: routes,
    );
  }
}
