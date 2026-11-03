import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime dueDate;
  const CountdownTimer({super.key, required this.dueDate});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late DateTime _dueDate;
  late Duration _remainingTime;
  late Timer _timer;

  void _calculateRemainingTime() {
    setState(() {
      _remainingTime = _dueDate.difference(DateTime.now());
    });
  }

  void _updateRemainingTime() {
    if (_remainingTime.inSeconds > 0) {
      setState(() {
        _remainingTime = _dueDate.difference(DateTime.now());
      });
    } else {
      _timer.cancel();
    }
  }

  String _formattedDuration(Duration duration) {
    if (duration.isNegative) {
      return "Deadline passed";
    }

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return "$hours h $minutes m $seconds s";
  }

  @override
  void initState() {
    super.initState();
    _dueDate = widget.dueDate;
    _calculateRemainingTime();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => _updateRemainingTime(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String time = _formattedDuration(_remainingTime);
    return Text(time, style: TextStyle(color: Colors.red, fontSize: 18));
  }
}
