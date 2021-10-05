import 'package:deepika_assignment/Constants/constant.dart';
import 'package:flutter/material.dart';

class CustomWidget{


  static Widget getTextWidget(BuildContext context, String text, {FontWeight fontWeight = FontWeight.w400, double textSize = 16.0,
    TextAlign textAlign = TextAlign.start, Color textColor = Colors.white } ){
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: fontWeight,
        color: textColor
      ),

    );
  }

  static Widget getTextField(
      BuildContext context, TextEditingController controller, String hintText,
      {onChange}) {
    return  TextFormField(
      style: const TextStyle(fontSize: 14.0),
      controller: controller,
      decoration:  InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),

        hintText: hintText,

      ),
    );
  }

  static Widget getRoundedButtonWidget(BuildContext context, String buttonText, {onTap}){
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(Constant.instance.appDefaultSpacing),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(24.0),
          color: Colors.blue,
        ),
        child: CustomWidget.getTextWidget(context, buttonText, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  static Widget getDefaultHeightSizedBox({double? height}){
    height ??= Constant.instance.appDefaultSpacing;
    return SizedBox(
      height: height,
    );
  }

  static Widget getDefaultWidthSizedBox({double? width}){
    width ??= Constant.instance.appDefaultSpacing;
    return SizedBox(
      width: width,
    );
  }
}