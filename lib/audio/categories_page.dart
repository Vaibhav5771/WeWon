import 'package:flutter/material.dart';
import '../pages/healer_dealer_page.dart';
import 'audio_ui.dart';


class AudioCategoriesScreen extends StatelessWidget {
  final List<String> categories = [
    'Relationship',
    'Health',
    'Career',
    'Emotional'
  ];

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
        backgroundColor: Color(0xFF3AA1ED),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HealerDealerPage()), // Navigate to HealerDealerPage
            );
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                _buildCategoryCircle(context, categories[0], width * 0.1, height * 0.1),
                _buildCategoryCircle(context, categories[1], width * 0.60, height * 0.50),
                _buildCategoryCircle(context, categories[2], width * 0.15, height * 0.45),
                _buildCategoryCircle(context, categories[3], width * 0.55, height * 0.15),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3AA1ED),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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

  Widget _buildCategoryCircle(BuildContext context, String category, double left, double top) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AudioPlayerScreen(category: category.toLowerCase())),
          );
        },
        child: Container(
          width: 144,
          height: 135,
          decoration: const ShapeDecoration(
            color: Color(0xFF3AA1ED),
            shape: OvalBorder(),
          ),
          child: Center(
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
