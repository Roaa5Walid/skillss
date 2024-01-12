import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../dataa.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class University extends StatefulWidget {
  const University({super.key});

  @override
  State<University> createState() => _UniversityState();
}

class _UniversityState extends State<University> {
  String? urlImage;
  PickedFile? pickerImage;
  String status = "";
  io.File? imageFile;
  final imagepicked = ImagePicker();
  PickedFile? _imageFile;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          // Cast the XFile to PickedFile as they have compatible properties
          _imageFile = image as PickedFile?; // Safe downcast
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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

                                    textfielBox(universityNameController, "اسم الجامعة"),
                                    textfielBox(universityLocationController, "موقع الجامعة"),
                                    textfielBox(numberOfStudentsController, "عدد الطلاب الاجمالي"),
                                    textfielBox(yearFoundedController, "سنة التاسيس"),
                                    textfielBox(universityEmailController, "الايميل"),
                                    textfielBox(universityDescriptionController, "وصف الجامعة"),
                                    textfielBox(universityDescriptionController, "احتياجات الجامعة"),
                                    //image
                                    Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            // تنفيذ الإجراء عندما يكون النموذج صالحًا
                                            setState(() {
                                              universityName = universityNameController.text;
                                              universityLocation = universityLocationController.text;
                                              numberOfStudents=numberOfStudentsController.text;
                                              universityEmail=universityEmailController.text;
                                              universityDescription=universityDescriptionController.text;
                                              universityNeeds=universityNeedsController.text;
                                              main();
                                              // place=placeOforder;
                                              // fetchDataAndTokens();
                                            });
                                          }
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
    );
  }
}
