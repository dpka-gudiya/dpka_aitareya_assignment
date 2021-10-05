import 'dart:math';

import 'package:flutter/material.dart';

extension RandomListItem<T> on List<T> {
  T randomItem()  {
    return this[Random().nextInt(length)];
  }
}


