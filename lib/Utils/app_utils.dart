
import 'package:flutter/material.dart';

class AppUtils{
  static void refreshCurrentState(State state) {
    if(state.mounted) {
      state.setState(() {});
    }
  }
}