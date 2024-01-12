import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Communication extends StatefulWidget {
  const Communication({super.key});

  @override
  State<Communication> createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
appBar: AppBar(
    backgroundColor:const Color(0xff041038) ,
    title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('تواصل معناا',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,color: Colors.orange,fontFamily: "Cairo"),
  ),
    ]
  )
),
      body: Center(
        child: ListView(
          children: [
            IconButton(onPressed: () {email();}, icon: const Icon(Icons.email_outlined,color: Color(0xff041038),size: 30,),),
            IconButton(onPressed: () { whatsapp();}, icon: const Icon(Icons.phone,color: Color(0xff041038),size: 30,),),
            IconButton(onPressed: () {sms();}, icon: const Icon(Icons.email,color: Color(0xff041038),size: 30,),),
            IconButton(onPressed: () { whatsapp();}, icon: const Icon(Icons.phone,color: Color(0xff041038),size: 30,),),

          ],
        ),
      ),
    );
  }
  calling()async{
    const url = 'tel:+9647705458521';
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  whatsapp() async {
    final whatsappUrl = "whatsapp://send?phone=+9647705458521";
    await launchUrlString(whatsappUrl);

    if (await canLaunchUrlString(whatsappUrl)) {
      await launchUrlString(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  messenger()async{
    const url = "http://m.me/xyzchannelxyz";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  sms()async{
    final url = 'sms:+9647705458521';
await launchUrlString(url);
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> email() async {
    final Uri _emailUrl = Uri(
      scheme: 'mailto',
      path: "roaa.waleed4000@gmail.com",
      queryParameters: {'subject': 'Hello'},
    );

    if (await canLaunchUrlString(_emailUrl.toString())) {
      await launchUrlString(_emailUrl.toString());
    } else {
      throw 'Could not launch $_emailUrl';
    }
  }
}
