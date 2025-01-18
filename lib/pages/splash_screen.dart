import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
// import 'home_page.dart'; // 실제 앱의 홈 페이지로 이동할 페이지를 가져옵니다.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  // SharedPreferences를 통해 첫 실행 여부를 확인
  void _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');

    if (isFirstTime == null || isFirstTime) {
      // 첫 실행이라면 로딩 화면을 보여주고, 첫 실행 상태를 false로 저장
      prefs.setBool('isFirstTime', false);
    }

    // 로딩 화면을 3초동안 보여주고, 홈 화면으로 이동
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 배경 이미지 설정
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib//images/herkstools.png'), // 배경 이미지 경로
            fit: BoxFit.cover, // 화면을 가득 채우도록 설정
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 이
              SizedBox(
                height: 450,
              ),
              Text(
                '헉스툴즈에 오신걸환영합니다\n 간편하고 신속한앱을 경험해보세요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              // 로딩 표시
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              // SizedBox(height: 430),
              SizedBox(height: 150),
              Text(
                '헉스클린소프트 \n 010.9642.4467',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
