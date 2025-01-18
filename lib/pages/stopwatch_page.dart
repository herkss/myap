import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  bool _isRunning = false;
  int _milliseconds = 0;
  Timer? _timer;
  final List<String> _laps = [];

  void _startStopwatch() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds += 10;
      });
    });
  }

  void _stopStopwatch() {
    _isRunning = false;
    _timer?.cancel();
  }

  void _resetStopwatch() {
    _isRunning = false;
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _laps.clear();
    });
  }

  void _recordLap() {
    setState(() {
      _laps.add(_formattedTime());
    });
  }

  String _formattedTime() {
    final int seconds = _milliseconds ~/ 1000;
    final int minutes = seconds ~/ 60;
    final int displaySeconds = seconds % 60;
    final int displayMilliseconds = _milliseconds % 1000 ~/ 10;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${displaySeconds.toString().padLeft(2, '0')}.'
        '${displayMilliseconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                _formattedTime(),
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? null : _startStopwatch,
                child: const Text('Start'),
              ),
              ElevatedButton(
                onPressed: !_isRunning ? null : _stopStopwatch,
                child: const Text('Stop'),
              ),
              ElevatedButton(
                onPressed: _recordLap,
                child: const Text('Lap'),
              ),
              ElevatedButton(
                onPressed: _resetStopwatch,
                child: const Text('Reset'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Lap ${index + 1}: ${_laps[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
