import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:skillss/dataa.dart';

const newstatus2="0";
var c_nameController = TextEditingController();
var c_phoneController = TextEditingController();
var c_passwordController = TextEditingController();

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signupState();
}

class _signupState extends State<signin> {
  Future Add_data() async {
    var url = Uri.parse("http://localhost:4000/add");
    Map<String, String> headers = {"Content-type": "application/json"};

    String json = '{"u_name": "$nameup",'
        ' "u_phone": "$phoneup",'
        ' "u_password": "$passwordup",'
        ' "status": "0"}';
    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body1 = response.body;
    var data = jsonDecode(body1);
    print(data);
    var res = data["code"];

    if (res == null) {}
  }

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
                  SizedBox(height: 15,),
                  Text("Welcom to SKILLS !",style: TextStyle(color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,),),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextField(
                            controller: c_nameController,
                            maxLength: 50,
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
                              hintText: "name",
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        TextField(
                          controller: c_phoneController,
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
                            hintText: "+964 " + "phoneNumber",
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                            LengthLimitingTextInputFormatter(15),
                            //PhoneNumberFormatter(),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        TextField(
                          controller: c_passwordController,
                          maxLength: 11,
                          cursorColor: Color(0xffffffff),
                          style: const TextStyle(color: Color(0xffffffff)),
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
                            hintText:"password",
                          ),
                          obscureText: true,
                        ),

                        SizedBox(
                          height: 20,
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
                        var phoneNumber = c_phoneController.text;
                        if (phoneNumber.startsWith("+964")) {
                          _submitForm();
                          // Navigator.of(context).push(
                          // MaterialPageRoute(builder: (context) => Home(u_name: nameup, u_phone: phoneup,u_password: passwordup,)),
                          //);
                          setState(() {
                            nameup = c_nameController.text;
                            phoneup = c_phoneController.text;
                            passwordup = c_passwordController.text;
                            Add_data();
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
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  void _submitForm() {
    var phoneNumber = c_phoneController.text;
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


