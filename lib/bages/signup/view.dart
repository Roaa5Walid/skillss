import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:skillss/dataa.dart';

import '../home/view.dart';
import '../sign in/view.dart';

const newstatus2="0";
var c_nameController = TextEditingController();
var phoneController = TextEditingController();
var c_passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var litems = [];
  bool chick = false;
  /*
  Future getData() async{
    var url=Uri.parse("http://localhost:4000");
    Response response= await get(url);
    String body =response.body;

    List<dynamic> list1=json.decode(body);
    print(list1);
    //litems.clear();  //to not print the items in litems just print value in mySql colum(name ,phone,..)
    for (int i=0; i<list1.length; i++){
      litems.add(list1[i]["name"]);
      litems.add(list1[i]["phone"]);
      setState(() {
        // if the name in mySql == name you inter
        if((list1[i]["u_name"])==nameup&&list1[i]["u_phone"]==phoneup){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Home()));
        }
        else
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => signin()));
      });

    }
    print(litems);


  }

   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff041038),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: AssetImage(
                                "images/logo.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  spreadRadius: 10,
                                  offset: Offset(0, 7),
                                  color: Colors.black26
                              )
                            ],
                            //color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        textfielBox(c_nameController,"name"),
                        textfielBox(c_passwordController, "password"),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: phoneController,
                          maxLength: 15,
                          cursorColor: Color(0xffffffff),
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 12,
                            ),
                            fillColor: Colors.grey.withOpacity(0.3),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "+964 رقم الهاتف",
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                            LengthLimitingTextInputFormatter(15),
                            //PhoneNumberFormatter(),
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50, // <-- match-parent
                    child: ElevatedButton(
                      onPressed: () {
                        var phoneNumber = phoneController.text;
                        if (phoneNumber.startsWith("+964")) {
                          _submitForm();
                         Navigator.of(context).push(
                           MaterialPageRoute(builder: (context) => Home()),
                          );
                          setState(() {
                            //nameup = c_nameController.text;
                           // phoneup = c_phoneController.text;
                           // passwordup = c_passwordController.text;مااحتاجه

                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text("Please enter a valid phone number with country code +964"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        "next",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff47B5FF),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        primary: Color(0xffffffff),
                        side: BorderSide(
                          width: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
  void _submitForm() {
    var phoneNumber = phoneController.text;
    if (phoneNumber.startsWith("+964")) {
      // إذا تم إدخال رمز الدولة بشكل صحيح، يمكن استمرار عملية الإرسال
      // ...
    } else {
      // إذا لم يتم إدخال رمز الدولة بشكل صحيح، يتم إظهار رسالة خطأ للمستخدم
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Please enter a valid phone number with country code +964"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}


/*

 */