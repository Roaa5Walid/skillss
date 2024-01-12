import 'dart:io' as io;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillss/bages/home/view.dart';
import 'package:skillss/bages/jobs/view.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import '../../../dataa.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class CreateCV extends StatefulWidget {
  const CreateCV({super.key});

  @override

  State<CreateCV> createState() => _CreateCVState();
}

class _CreateCVState extends State<CreateCV> {
  @override
  void initState() {
    super.initState();
    post(); // استدعاء الدالة لتهيئة SharedPreferences
  }

  String status = "";
  late XFile _imageFile = XFile("");

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          _imageFile = image;
        });
        print('Image picked: ${_imageFile.path}');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  Future<void> post() async {
    try {
      if (_imageFile == null || _imageFile.path.isEmpty) {
        print('No image file selected');
        return;
      }

      // Fetch CSRF token and session ID
      var result = await fetchDataAndTokens();
      var csrfToken = result['csrfToken']!;
      var sessionId = result['sessionId']!;

      // Server URL and headers
      var url = Uri.parse('https://www.skillsiraq.com/edu/make_cv/');
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'csrftoken=$csrfToken; sessionid=$sessionId',
        'X-CSRFToken': '$csrfToken',
        'Referer': 'https://www.skillsiraq.com/edu/make_cv/',
      };

      // Create a MultipartRequest
      var request = http.MultipartRequest('POST', url);

      // Add headers
      request.headers.addAll(headers);

      // Add form fields
      var data = {
        "full_name": "John Doe",
        "phone_number": "1234567890",
        "email": "john@example.com",
        "address": "123 Main St, City",
        "birth_day": "15",
        "birth_month": "5",
        "birth_year": "1990",
        "language": "English",
        "image": _imageFile.path,
        "courses_and_training": "Course 1: Description, Course 2: Description",
        "work_experience": "Company X: Role, Company Y: Role",
        "university_info": "University XYZ, Degree in ABC",
        "university_start_year": "2015",
        "university_graduation_year": "2019",
      };

      // Add form fields
      request.fields.addAll(data);

      // Add the image file
      if (_imageFile != null && _imageFile.path.isNotEmpty) {
        var image = await http.MultipartFile.fromPath("image", _imageFile.path);
        request.files.add(image);
        print('Image file added: ${_imageFile.path}');
      } else {
        print('No image file or invalid path');
      }

      // Send the request
      var response = await request.send();

      // Get the response
      var responseString = await response.stream.bytesToString();

      // Handle the response
      if (response.statusCode == 200) {
        print('POST request successful');
        print('Response data: $responseString');
        if (responseString.contains('"success": true')) {
          print('CV submission successful');
        } else {
          print('CV submission failed');
        }
      } else {
        print('Failed to send POST request. Status code: ${response.statusCode}');
        print('Response data: $responseString');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, String>> fetchDataAndTokens() async {
    var url = Uri.parse('https://www.skillsiraq.com/edu/make_cv/');
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

                                    textfielBox(c_arnameController, "الاسم الثلاثي "),

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

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("اللغة",
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
                                                "عربي",
                                                "انكليزي"
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
                                            onPressed: ()  async {
                                              await _pickImage();
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
                                          child: _imageFile == null
                                ? Text('No image selected.')
                                    : Image.file(File(_imageFile!.path),
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: ElevatedButton(
                                        onPressed: () async{
                                          setState(() {
                                            arname= c_arnameController.text;
                                            phone=c_phoneController.text;
                                            email=c_emailController.text;
                                            address=c_addressController.text;
                                            day_birth=c_day_birthController.text;
                                            month_birth=c_month_birthController.text;
                                            year=c_yearController.text;
                                            course=c_courseController.text;
                                            expertise=c_expertiseController.text;
                                            college=c_collegeController.text;
                                            start_Year=c_start_YearController.text;
                                            graduation_Year=c_graduation_YearController.text;
                                            language=c_languageController.text;
                                            _imageFile.path;
                                            post();

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


/*
  Future<void> uploadImage() async {
    try {
      final pickedImage = await imagePicker.getImage(source: ImageSource.camera);
      print("Image Path: ${pickedImage?.path}");

      if (pickedImage != null) {
        setState(() {
          pickerImage = pickedImage;
          imageFile = io.File(pickedImage.path);
        });
      } else {
        // Handle case where no image is selected
        // You might want to display an error message or take appropriate action
      }
    } catch (e) {
      // Handle errors that might occur during image selection
      print('Error selecting image: $e');
    }
  }
Future<void> main() async {
  try {
    var csrfToken = '80piQroEp22MmOZYTTn5XMoLuJBhQHsc'; // استبدل بقيمة الـ CSRF Token الصحيحة
    var sessionId = ''; // يمكنك تركها فارغة إذا لم تحتاج إليها

    // Server URL
    var url = Uri.parse('https://www.skillsiraq.com/edu/make_cv/');

    // Create a MultipartRequest
    var request = http.MultipartRequest('POST', url);

    // Add headers
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Cookie': 'csrftoken=$csrfToken; sessionid=$sessionId',
      'X-CSRFToken': '$csrfToken',
      'Referer': 'https://www.skillsiraq.com/edu/make_cv/',
    });

    // Fetch CSRF token and session ID
    var result = await fetchDataAndTokens();
    csrfToken = result['csrfToken']!;
    sessionId = result['sessionId']!;

    // Form data
    var data = {
      "full_name": "John Doe",
      "phone_number": "1234567890",
      "email": "john@example.com",
      "address": "123 Main St, City",
      "birth_day": "15",
      "birth_month": "5",
      "birth_year": "1990",
      "courses_and_training": "Course 1: Description, Course 2: Description",
      "work_experience": "Company X: Role, Company Y: Role",
      "university_info": "University XYZ, Degree in ABC",
      "university_start_year": "2015",
      "university_graduation_year": "2019",
      "language": "English",
    };

    // Add form fields
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // Add the image file
    if (_imageFile != null && _imageFile!.path.isNotEmpty) {
      var image = await http.MultipartFile.fromPath("image", _imageFile!.path);
      request.files.add(image);
      print('yaaa: ${_imageFile?.path}');
    } else {
      print('noooo:');
    }

    // Send the request
    var response = await request.send();

    // Get the response
    var responseString = await response.stream.bytesToString();

    // Handle the response
    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response data: $responseString');
      if (responseString.contains('"success": true')) {
        print('CV submission successful');
      } else {
        print('CV submission failed');
      }
    } else {
      print('Failed to send POST request. Status code: ${response.statusCode}');
      print('Response data: $responseString');
    }
  } catch (e) {
    print('Error: $e');
  }
}

 */
/*
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    try {
      PickedFile? image = await _picker.getImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          _imageFile = image;
          print('Image Path: ${_imageFile?.path}');
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

 */