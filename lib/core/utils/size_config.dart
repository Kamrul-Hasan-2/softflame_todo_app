import 'package:flutter/cupertino.dart';

class SizeConfigs {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  static double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputHeight) {
    return (inputHeight / 375) * screenWidth;
  }
}
