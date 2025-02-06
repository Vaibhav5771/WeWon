import 'package:flutter/material.dart';
import 'package:wewon/pages/timer.dart';

import 'healer_dealer_page.dart';

class VoiceScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9DD3FB),
      body: Stack(
        children: [
          // Back Icon
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),

              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HealerDealerPage()), // Navigate to HealerDealerPage
                );
              },
            ),
          ),

          // Microphone Circle
          Positioned(
            top: 200,
            left: (MediaQuery.of(context).size.width / 2) - 75,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(Icons.mic, size: 60, color: Colors.black),
              ),
            ),
          ),

          // Start Button
          // Start Button
          Positioned(
            top: 400,
            left: (MediaQuery.of(context).size.width / 2) - 90,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordingPage()),
                );
              },
              child: Container(
                width: 180,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xFF3FCE49),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),


          // Bottom Bar with Text
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF3AA1ED),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: const Center(
                child: Text(
                  '“Share with me, how are you feeling today...”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

