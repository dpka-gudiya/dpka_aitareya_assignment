import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'PrintUtils.dart';

class ToastUtils {

  static void show(String msg) {
    try {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 10.0
      );
    } catch(e) {
      PrintUtils.printLog("Exception in showing Toast -> ${e.toString()}");
    }
  }
}