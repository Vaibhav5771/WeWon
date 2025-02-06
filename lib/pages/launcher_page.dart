import 'package:flutter/material.dart';
import 'package:wewon/pages/healer_dealer_page.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    // Animate background color from blue to white
    _colorAnimation = ColorTween(
      begin: const Color(0xFF80CEEC), // Blue
      end: Colors.white, // White
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0,
          0.7), // Color transition happens in the first 70% of the animation
    ));

    // Animate opacity of the corners
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7,
          1.0), // Opacity transition happens in the last part of the animation
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToDealerHealerPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HealerDealerPage()),
    ); // Replace with your page route
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;

        // Dot Y Position
        final dotYPosition = Tween<double>(begin: -300, end: 0)
            .transform(Interval(0.1, 0.5).transform(progress));

        // Dot scales up
        final scale = Tween<double>(begin: 0.1, end: 1.0)
            .transform(Interval(0.4, 0.7).transform(progress));

        // Logo flip effect
        final flipRotation = Tween<double>(begin: 0, end: 3.14)
            .transform(Interval(0.7, 1.0).transform(progress));

        return Scaffold(
          backgroundColor: _colorAnimation.value,
          // Use animated background color
          body: Stack(
            children: [
              // Top-right half circle
              Positioned(
                top: -150,
                right: -150,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF80CEEC),
                    ),
                  ),
                ),
              ),
              // Bottom-left half circle
              Positioned(
                bottom: -150,
                left: -150,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF80CEEC),
                    ),
                  ),
                ),
              ),
              // Center content
              Center(
                child: Transform.translate(
                  offset: Offset(0, dotYPosition),
                  child: Transform.scale(
                    scale: scale,
                    child: Transform(
                      transform: Matrix4.identity()..rotateY(flipRotation),
                      alignment: Alignment.center,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: progress > 0.7
                            ? Center(
                                child: Image.asset(
                                  'assets/Logo.png',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              // Button to navigate
              if (progress >= 1.0) // Show button after animation completes
                Center(
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      onPressed: _navigateToDealerHealerPage,
                      child: const Text(""),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Make background transparent if needed
                        disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12), // Make the button color transparent if needed
                        shadowColor: Colors.transparent, // Remove any shadows if desired
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
