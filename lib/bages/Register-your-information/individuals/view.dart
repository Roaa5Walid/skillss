import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillss/bages/home/view.dart';
import 'package:skillss/bages/jobs/view.dart';

import '../../../dataa.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class Individuals extends StatefulWidget {
  const Individuals({super.key});

  @override
  State<Individuals> createState() => _IndividualsState();
}

class _IndividualsState extends State<Individuals> {
  String? urlImage;
  PickedFile? pickerImage;
  String status = "";
  io.File? imageFile;
  final imagepicked = ImagePicker();

  uploadImage() async {
    var pickedimage = await imagepicked.getImage(source: ImageSource.camera);
    if (pickedimage != null) {
      setState(() {
        pickerImage = pickedimage;
        imageFile = io.File(pickedimage.path);
      });
    } else {}
  }

  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }


  void main() async {
    try {
      var result = await fetchDataAndTokens();
      var csrfToken = result['csrfToken']!;
      var sessionId = result['sessionId']!;

      var url = Uri.parse('https://www.skillsiraq.com/edu/api/register_university/');
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'csrftoken=$csrfToken; sessionid=$sessionId',
        'X-CSRFToken': '$csrfToken',
      };

      var data = {
        "name": "University Name",
        "established_year": "1990",
        "total_students": "5000",
        "description": "This is a description of the university.",
        "location": "City, Country",
        "needs": "Requirements or needs of the university.",
        "email": "university@example.com",
      };

      await postData(url, headers, data, csrfToken, sessionId);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, String>> fetchDataAndTokens() async {
    var url = Uri.parse('https://www.skillsiraq.com/edu/register/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, String> cookies = _parseCookies(response);

      String csrfToken = cookies['csrftoken'] ?? '';
      String sessionId = cookies['sessionid'] ?? '';

      print('CSRF Token: $csrfToken');
      print('Session ID: $sessionId');

      return {'csrfToken': csrfToken, 'sessionId': sessionId};
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return {'csrfToken': '', 'sessionId': ''};
    }
  }

  Map<String, String> _parseCookies(http.Response response) {
    String? rawCookieHeader = response.headers['set-cookie'];

    if (rawCookieHeader != null) {
      Map<String, String> cookies = {};

      RegExp regex = RegExp(r'(\w+)=(\w+);');
      Iterable<RegExpMatch> matches = regex.allMatches(rawCookieHeader);

      for (RegExpMatch match in matches) {
        if (match.groupCount == 2) {
          String key = match.group(1)!;
          String value = match.group(2)!;
          cookies[key] = value;
        }
      }

      return cookies;
    } else {
      print('Cookie header not found.');
      return {};
    }
  }

  Future<void> postData(Uri url, Map<String, String> headers, Map<String, dynamic> formData, String csrfToken, String sessionId) async {
    var fullUrl = Uri.parse('https://www.skillsiraq.com/edu/api/register_university/');

    // Add the Referer header to satisfy CSRF protection
    headers['Referer'] = 'https://www.skillsiraq.com/edu/register/';

    try {
      var response = await http.post(
        fullUrl,
        headers: headers,
        body: formData,
      );

      if (response.statusCode == 200) {
        print('POST request successful');
        print('Response data: ${response.body}');
        print('Response headers: ${response.headers}');

        // Check the response from the server for successful registration
        if (response.body.contains('"success": true')) {
          // Handle successful registration, e.g., navigate to a success page
          print('Registration successful');
        } else {
          // Handle unsuccessful registration
          print('Registration failed');
        }
      } else {
        print('Failed to send POST request. Status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }


//GOODLUCK! :)
/*
{"name": "University Name",
      "established_year": 1990,
      "total_students": 5000,
      "description": "This is a description of the university.",
      "location": "City, Country",
      "needs": "Requirements or needs of the university.",
      "email": "university@example.com"};
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff041038),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Skills",
                    style: TextStyle(color: Colors.orange, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 80, left: 10, right: 10, bottom: 150),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 650, //or MediaQuery.of(context).size.width+300
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            )),
                        child: Form(
                          key: _formKey,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int i) {
                                return  Column(
                                  children: [

                                    textfielBox(c_arnameController, "الاسم الثلاثي بالعربي"),
                                    textfielBox(c_ennameController, "الاسم الثلاثي بالانكليزي"),

                                    /*
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("placeOfOrder",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black
                                                            .withOpacity(0.3)),
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    underline: Container(),
                                                    value: dropdownValue,
                                                    // Step 4.
                                                    items: <String>[
                                                      "",
                                                     "inside",
                                                      "outside"
                                                    ].map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                            (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            enabled: value != "",
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            onTap: () {},
                                                          );
                                                        }).toList(),
                                                    // Step 5.
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue = newValue!;
                                                        //placeOforder = newValue;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("typeOfPassport",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                       */
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_phoneController,
                                        validator: (c_phoneController) {
                                          if (c_phoneController != null &&
                                              c_phoneController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(25),
                                              )),
                                          labelText:"رقم الهاتف",
                                          hintText:
                                          "رقم الهاتف",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    textfielBox(c_emailController, "البريد الالكتروني"),
                                    textfielBox(c_addressController, "عنوانالسكن"),
                                    textfielBox(c_day_birthController, "يوم المولد"),
                                    textfielBox(c_month_birthController, "شهر المولد"),
                                    textfielBox(c_yearController, "سنة المولد"),
                                    textfielBox(c_courseController, "اسم الكورسات والتدريبات ان وجدت"),
                                    textfielBox(c_expertiseController, "الخبرة العملية اذا كنت تعمل سابقا"),
                                    textfielBox(c_collegeController, "اسم الجامعه والكليةوالقسم"),
                                    textfielBox(c_start_YearController, "سنة البداية في الجامعة"),
                                    textfielBox(c_graduation_YearController, "سنة التخرج"),
                                    textfielBox(c_cvController, "السيرة الذاتية"),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                        Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("خريج",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width:MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black
                                                            .withOpacity(0.3)),
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    underline: Container(),
                                                    value: dropdownValue,
                                                    // Step 4.
                                                    items: <String>[
                                                      "",
                                                     "نعم",
                                                      "كلا"
                                                    ].map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                            (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            enabled: value != "",
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            onTap: () {},
                                                          );
                                                        }).toList(),
                                                    // Step 5.
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue = newValue!;
                                                        //placeOforder = newValue;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),

                                      ),



                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(25),
                                          child: MaterialButton(
                                            onPressed: () {
                                              uploadImage();
                                            },
                                            height: 50,
                                            shape: const StadiumBorder(),
                                            color:
                                            Colors.white.withOpacity(0.7),
                                            child: Center(
                                              child: Text("placePhoto",
                                                style: const TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //image
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                          child: imageFile == null
                                              ? Text("image")
                                              : Image.file(imageFile!),
                                        ),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            main();
                                          });
                                          /*
            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
            setState(() {
            main();
            });
            }

                                           */
            },

            // تنفيذ الإجراء عندما يكون النموذج صالحًا



                                        child: Text("next",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            elevation: 5,
                                            primary: Color(0xffffffff),
                                            // padding: EdgeInsets.symmetric(horizontal:200, vertical: 20),
                                            side: BorderSide(
                                              width: 0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  20,
                                                ))),
                                      ),
                                    ),

                                  ],

                                );
                              }),
                        ),
                      ),
                      Positioned(
                        top: -80,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
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
                                    color: Colors.black26)
                              ],
                              // color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            );
          }),
    );  }
}
