import 'package:flutter/material.dart';
abstract class AppStyle{
  static TextStyle styleRegular12 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 12),
        fontWeight: FontWeight.w400,
        fontFamily:'georgia',
        color:Color(0xff05162C)
    );
  }
  static TextStyle styleRegular14 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 14),
        fontWeight: FontWeight.w400,
        fontFamily:'georgia',
        color:Color(0xff05162C)
    );
  }
  static TextStyle styleRegular16 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 16),
        fontWeight: FontWeight.w400,
        fontFamily:'georgia',
        color:Color(0xff000000)
    );
  }
  static TextStyle styleRegular20 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 20),
        fontWeight: FontWeight.w400,
        fontFamily:'georgia',
        color:Color(0xff000000)
    );
  }
  static TextStyle styleRegular24 (BuildContext context){
    return  TextStyle(
      fontSize:getResponsive(context, fontSize: 24),
      fontWeight: FontWeight.w400,
      fontFamily:'georgia',
      color:Color(0xff05162C)
    );
  }
  static TextStyle styleRegular32 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 32),
        fontWeight: FontWeight.w400,
        fontFamily:'georgia',
        color:Color(0xff05162C)
    );
  }
  static TextStyle styleRegular40 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 40),
        fontWeight: FontWeight.w400,
        fontFamily:'georgia',
        color:Color(0xff05162C)
    );
  }
  static TextStyle styleMedium12 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 12),
        fontWeight: FontWeight.w500,
        fontFamily:'Montserrat',
        color:Color(0xff99A2AB)
    );
  }
  static TextStyle styleMedium14 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 14),
        fontWeight: FontWeight.w400,
        fontFamily:'Montserrat',
        color:Color(0xff145DB8)
    );
  }
  static TextStyle styleMedium16 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 16),
        fontWeight: FontWeight.w500,
        fontFamily:'Montserrat',
        color:Color(0xff6D7379)
    );
  }
  static TextStyle styleMedium20 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 20),
        fontWeight: FontWeight.w500,
        fontFamily:'Montserrat',
        color:Color(0xff6D7379)
    );
  }
  static TextStyle styleMedium32 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 32),
        fontWeight: FontWeight.w500,
        fontFamily:'Montserrat',
        color:Color(0xff05162C)
    );
  }
  static TextStyle styleMedium40 (BuildContext context){
    return  TextStyle(
        fontSize:getResponsive(context, fontSize: 40),
        fontWeight: FontWeight.w500,
        fontFamily:'Montserrat',
        color:Color(0xff05162C)
    );
  }

}

// function to make fontSize responsive

double getResponsive(BuildContext context,{required double fontSize}){
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize  = scaleFactor * fontSize;
  double lowerLimit = responsiveFontSize * 0.8;
  double upperLimit = responsiveFontSize * 1.2;
  return  responsiveFontSize.clamp(lowerLimit, upperLimit);
}
double getScaleFactor(BuildContext context){
  double width = MediaQuery.of(context).size.width;
  if (width < 600 ){
    return width / 400;
  }
  else if(width < 900){
    return width / 700;
  }
  else{
    return width / 1000;
  }
}