import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/src/screens/home/widgets/numbergrid.widget.dart';
import 'package:jeet_ke_jeo/src/screens/home/widgets/pinfield.widget.dart';

final GlobalKey<NumberGridState> numberGridKey = GlobalKey();
List<GlobalKey<PinFieldState>> keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];