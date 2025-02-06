import 'package:flutter/material.dart';
import 'dart:async';

import 'package:wewon/pages/voice_stop.dart';


class RecordingPage extends StatefulWidget {
  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _dotAnimation;
  int _countdown = 3;
  bool _countdownStarted = false;
  bool _recordingStarted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _dotAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.3))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _countdownStarted = true;
      });
      _startCountdown();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          _showRecordingUI();
        }
      });
    });
  }

  void _showRecordingUI() {
    setState(() {
      _recordingStarted = true;
    });
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VoiceStop()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF80CEEC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            if (!_recordingStarted) ...[
              Text(
                "Get ready!",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Akronim', // Apply custom font for "Get ready!"
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Recording starts in",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              if (!_countdownStarted)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return SlideTransition(
                      position: _dotAnimation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          ".",
                          style: TextStyle(
                            fontSize: 96,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                )
              else
                Text(
                  "$_countdown",
                  style: TextStyle(
                    fontSize: 96,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              SizedBox(height: 10),
              Text(
                "SECONDS",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    "assets/voice.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ] else ...[
              Text(
                "Recording",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: GestureDetector(
                  onTap: _navigateToNextPage,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/pause-button.png", // Pause icon
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
