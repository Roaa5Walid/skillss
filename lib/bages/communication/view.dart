import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../dataa.dart';

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
    Center(
      child: Text('تواصل معناا',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,color: Colors.orange,fontFamily: "Cairo"),
  ),
    ),
    ]
  )
),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: Image.network(
                  'https://path_to_your_svg_image.com/image.svg', // رابط الصورة
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'يمكنك طلب المساعدة عن طريق',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              xx("تواصل معناعلب الواتساب","0xFF25D366" , whatsapp, "https://1000logos.net/wp-content/uploads/2021/04/WhatsApp-logo.png"),

              xx("تواصل معنا عبر الفيسبوك","0xFF007af3" , whatsapp, "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/600px-Facebook_f_logo_%282019%29.svg.png?20231203063624"),
              bo("0xFF25D366", "تواصل معنا عبر الواتساب", whatsapp),
              ElevatedButton(
                style: customButtonStyle("0xFF25D366"),
                onPressed: () { whatsapp();},
                child: Text('تواصل معنا عبر الواتساب'),
              ),
              IconButton(onPressed: () {email();}, icon: const Icon(Icons.email_outlined,color: Color(0xff041038),size: 30,),),
              IconButton(onPressed: () { whatsapp();}, icon: const Icon(Icons.phone,color: Color(0xff041038),size: 30,),),
              IconButton(onPressed: () {sms();}, icon: const Icon(Icons.email,color: Color(0xff041038),size: 30,),),
              IconButton(onPressed: () { whatsapp();}, icon: const Icon(Icons.phone,color: Color(0xff041038),size: 30,),),

            ],
          ),
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
  ButtonStyle customButtonStyle(String col) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color(int.parse(col))), // لون الخلفية
      shape: MaterialStateProperty.all<RoundedRectangleBorder>( // تحديد شكل الزوايا
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0), // جعل الزوايا مستديرة
              side: BorderSide(color: Color(0xff1e81b0)) // لون الحد الخارجي
          )
      ),
      elevation: MaterialStateProperty.all(5.0), // الظل خلف الزر
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)), // التباعد الداخلي
    );
  }
  ElevatedButton bo(String col,String text,VoidCallback onPressed){
    return ElevatedButton(
      style: customButtonStyle(col),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            image: AssetImage('images/WhatsApp.svg'),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          Text(text,style:MyTextStyles.textStylePages(context,Colors.white.value)),
          Icon(Icons.arrow_forward,color: Colors.white,size: 30,),
///
        ],
      ),
    );
  }


  Padding xx(String text, String col,VoidCallback onTap,String img){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(int.parse(col)),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: NetworkImage(img),
              height: 50,width: 50,
              fit: BoxFit.cover,
            ),
            Text(text,style:MyTextStyles.textStylePages(context,Colors.white.value)),
            Icon(Icons.arrow_forward,color: Colors.white,size: 30,),

          ],
        ),
      ),
    );
  }

}
