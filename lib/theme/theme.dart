import 'dart:ui';


import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();
   
  static const Color loginGradientStart =const Color(0xFF8A2BE2); 
  static const Color bulecolors =const Color(0xFF0f73ee);
  static const Color loginGradientEnd = const Color(0xFF4B0082);


  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}