import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HayotSikl extends StatefulWidget {
  const HayotSikl({super.key});

  @override
  State<HayotSikl> createState() => _HayotSiklState();
}

class _HayotSiklState extends State<HayotSikl> with WidgetsBindingObserver {
  // final AppLifecycleListener _listener;
  final ScrollController _scrollController = ScrollController();
  final List<String> _states = <String>[];
  late AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _state = SchedulerBinding.instance.lifecycleState;
    // _listener = AppLifecycleListener(
    //   onShow: () => _handleTransition('show'),
    // );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("App RESUMED");
    } else if (state == AppLifecycleState.paused) {
      print("App PAUSED");
    } else if (state == AppLifecycleState.inactive) {
      print("App INACTIVE");
    } else if (state == AppLifecycleState.detached) {
      print("App DETACHED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text("App Lifecycle"))),
    );
  }
}
