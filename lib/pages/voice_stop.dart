import 'package:flutter/material.dart';
import 'package:wewon/pages/categories_dealer.dart';

class VoiceStop extends StatefulWidget {
  @override
  _VoiceStopState createState() => _VoiceStopState();
}

class _VoiceStopState extends State<VoiceStop> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderWidthAnimation;
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _borderWidthAnimation = Tween<double>(begin: 3, end: 6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _waveAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(color: Color(0xFF9DD3FB)),
        child: Stack(
          children: [
            Positioned(
              left: screenWidth * 0.25,
              top: screenHeight * 0.7,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesDealerPage(),
                    ), // Navigate to login page
                  );
                },
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    color: Color(0xFFD85656),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Stop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -2),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: List.generate(5, (index) {
                          double waveSize = screenWidth * (0.15 + index * 0.06);
                          if (waveSize * _waveAnimation.value > screenHeight * 0.6) {
                            waveSize = screenHeight * 0.6 / _waveAnimation.value;
                          }
                          return AnimatedBuilder(
                            animation: _waveAnimation,
                            builder: (context, child) {
                              return Container(
                                width: waveSize * _waveAnimation.value,
                                height: waveSize * _waveAnimation.value,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue.withOpacity((5 - index) * 0.1),
                                    width: 4,
                                  ),
                                ),
                              );
                            },
                          );
                        })
                          ..add(
                            Container(
                              width: screenWidth * 0.3,
                              height: screenWidth * 0.3,
                              decoration: ShapeDecoration(
                                color: Color(0xFFC4E5FD),
                                shape: OvalBorder(
                                  side: BorderSide(
                                    width: _borderWidthAnimation.value,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.mic,
                                  color: Colors.black,
                                  size: screenWidth * 0.15,
                                ),
                              ),
                            ),
                          ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Share with me how are you feeling today...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

