import 'package:flutter/material.dart';
import 'package:skillss/bages/signup/view.dart';





class Spla extends StatefulWidget {
  const Spla({Key? key}) : super(key: key);

  @override
  State<Spla> createState() => _SplaState();
}

class _SplaState extends State<Spla> {
  Future Delay() async{
    await Future.delayed(const Duration(seconds: 8));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => signup()));
  }
  @override
  void initState(){
    super.initState();
    Delay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff041038),
      body:Center(child: Image.asset("images/logo.png",width: 200,height: 200,)),

    );
  }
}