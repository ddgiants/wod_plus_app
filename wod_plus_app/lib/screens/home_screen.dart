import 'dart:async';

import 'package:flutter/material.dart';

String _twoDigits(int value) => value.toString().padLeft(2, '0');

String _formatTime(DateTime time) =>
    '${_twoDigits(time.hour)}:${_twoDigits(time.minute)}:${_twoDigits(time.second)}';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _scheduleNextTick();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scheduleNextTick() {
    final delay = Duration(seconds: 1) -
        Duration(milliseconds: DateTime.now().millisecond);
    _timer = Timer(delay, () {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
      _scheduleNextTick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wod Plus'),
      ),
      body: Center(
        child: Text(
          _formatTime(_now),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
