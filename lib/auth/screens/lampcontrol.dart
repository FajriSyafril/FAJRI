import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF3498db);
  static const Color primaryHighContrast = Color(0xFFFFFFFF);
  static const Color primaryDark = Color(0xFF2c3e50);
  static const Color whiteColor = Colors.white;
  // Add more color constants as needed
}

class LampControlScreen extends StatefulWidget {
  // Corrected the constructor declaration
  const LampControlScreen({Key? key, required this.controller}) : super(key: key);

  final PageController controller;

  @override
  State<LampControlScreen> createState() => _LampControlScreenState();
}

class _LampControlScreenState extends State<LampControlScreen> {
  bool isLampOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.of(context).size,
        child: Stack(
          children: [
            _buildImage('assets/pngs/medical.png', 60, pi * .1, right: 40, top: 140),
            _buildImage('assets/pngs/health-care.png', 50, -pi * 0.05, left: 80, top: 300),
            _buildImage('assets/pngs/antibiotic.png', 120, -pi * 0.14, right: 10, bottom: 20),
            _buildImage('assets/svgs/pills.svg', 300, 0, left: -50, top: 10),
            Positioned(
              left: 30,
              right: 30,
              bottom: 30,
              child: _buildLampControlContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String assetPath, double width, double angle, {double? left, double? right, double? top, double? bottom}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Transform.rotate(
        angle: angle,
        child: assetPath.endsWith('.svg') ? SvgPicture.asset(assetPath, width: width) : Image.asset(assetPath, width: width),
      ),
    );
  }

  Widget _buildLampControlContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.whiteColor.withOpacity(.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Lamp Control',
            style: TextStyle(
              color: AppColors.primaryHighContrast,
              fontSize: 27,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Switch(
            value: isLampOn,
            onChanged: (value) {
              setState(() {
                isLampOn = value;
                // Perform action when the lamp state changes
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _toggleLamp,
            style: ElevatedButton.styleFrom(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.whiteColor,
            ),
            child: Text('Toggle Lamp'),
          ),
        ],
      ),
    );
  }

  void _toggleLamp() {
    // Perform action when the button is pressed
  }
}
