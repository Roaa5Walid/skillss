import 'package:flutter/material.dart';
import 'package:skillss/bages/communication/view.dart';
import 'package:skillss/bages/home/view.dart';
import 'package:skillss/bages/jobs/tt.dart';
import 'package:skillss/bages/jobs/view.dart';
import 'package:skillss/bages/sign%20in/view.dart';
import 'package:skillss/spla/view.dart';
import 'package:skillss/test2.dart';
import 'package:skillss/testt.dart';

import 'bages/Register-your-information/individuals/view.dart';
import 'bages/bottonNevegation/view.dart';
import 'bages/services/Create_CV/view.dart';
import 'bages/signup/view.dart';

void main() {
  runApp(MyApp());
}
///////mor
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:CreateCV2(),
    );
  }
}