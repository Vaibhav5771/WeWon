import 'package:flutter/material.dart';
import 'package:wewon/pages/done_page.dart';
import 'package:wewon/pages/voice_start.dart';

class CategoriesDealerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF3AA1ED),
        centerTitle: true,
        elevation: 0, // Removes the AppBar shadow
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                // Relationship Circle
                Positioned(
                  left: width * 0.1,
                  top: height * 0.1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DonePage()),
                      );
                    },
                    child: _buildCategoryCircle('Relationship'),
                  ),
                ),

                // Health Circle
                Positioned(
                  left: width * 0.60,
                  top: height * 0.50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DonePage()),
                      );
                    },
                    child: _buildCategoryCircle('Health'),
                  ),
                ),

                // Career and Growth Circle
                Positioned(
                  left: width * 0.15,
                  top: height * 0.45,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DonePage()),
                      );
                    },
                    child: _buildCategoryCircle('Career and Growth'),
                  ),
                ),

                // Emotional well-being Circle
                Positioned(
                  left: width * 0.55,
                  top: height * 0.15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DonePage()),
                      );
                    },
                    child: _buildCategoryCircle('Emotional well-being'),
                  ),
                ),

                // Bottom Text Section
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
        },
      ),
    );
  }

  // Widget for category circles
  Widget _buildCategoryCircle(String text) {
    return Container(
      width: 150,
      height: 150,
      decoration: const ShapeDecoration(
        color: Color(0xFF3AA1ED),
        shape: OvalBorder(),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
