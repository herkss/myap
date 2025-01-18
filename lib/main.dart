import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/pages/alarm_page.dart';
import 'package:myapp/pages/calculator_page.dart';
import 'package:myapp/pages/clock_page.dart';
import 'package:myapp/pages/schedule_page.dart';
import 'package:myapp/pages/splash_screen.dart';
import 'package:myapp/pages/stopwatch_page.dart';
import 'package:myapp/pages/timer_page.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 애플리케이션 문서 경로 가져오기
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path); // Hive 초기화 경로 설정
  await Hive.openBox('schedules');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // const SplashScreen(),
    const CalculatorPage(),
    const SchedulePage(),
    const ClockPage(),
    const AlarmPage(),
    const StopwatchPage(),
    const TimerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: const SplashScreen(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.calculate),
              label: '계산기'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: '일정'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: '시계'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '알람'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: '스탑워치'),
          BottomNavigationBarItem(
              icon: Icon(Icons.hourglass_bottom), label: '현재시간'),
        ],
      ),
    );
  }
}
