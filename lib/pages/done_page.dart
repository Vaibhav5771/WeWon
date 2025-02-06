import 'package:flutter/material.dart';
import 'package:wewon/pages/healer_dealer_page.dart';

class DonePage extends StatefulWidget {
  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController with a faster duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Make the animation faster
    );

    // Define the Tween for flipping horizontally (1.0 means no flip, -1.0 means flipped)
    _flipAnimation = Tween<double>(begin: 1.0, end: -1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation when the page loads
    _controller.forward().then((_DonePageState) {
      // Once the first flip is done, flip it back to its original position
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3AA1ED),
        title: Text('Done'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HealerDealerPage()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Light blue background
        child: Stack(
          children: [
            // Centered Blue Rounded Rectangle
            Container(
              alignment: Alignment.center,
              child: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  color: Color(0xFF3AA1ED), // Blue
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Flip the container horizontally using Transform.scale
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..scale(_flipAnimation.value, 1.0,
                                1.0), // Flip horizontally
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.done,
                              color: Color(0xFF3AA1ED), // Blue color
                              size: 60,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50),
                    // "Your message is saved!" Text
                    Text(
                      "Your message is saved!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Rectangle
            Positioned(
              left: 0, // Extend to cover full width
              right: 0, // Extend to cover full width
              bottom: 0,
              child: Container(
                height: 150, // Increased height for better visibility
                decoration: BoxDecoration(
                  color: Color(0xFF3AA1ED), // Blue color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Share with me, how are you today...",
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
      ),
    );
  }
}