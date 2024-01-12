import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'dart:io' as io;

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:skillss/bages/home/view.dart';
import 'package:skillss/dataa.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class FormStart extends StatefulWidget {
  const FormStart({Key? key}) : super(key: key);

  @override
  State<FormStart> createState() => _FormStartState();
}

class _FormStartState extends State<FormStart> {
  String? urlImage;
  PickedFile? pickerImage;
  String status = "";
  void main() async {
    var result = await fetchDataAndTokens();
    var csrfToken = result['csrfToken']!;
    var sessionId = result['sessionId']!;

    var url = Uri.parse('https://skills.pythonanywhere.com/accounts/api/log-in/');
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'csrftoken=$csrfToken; sessionid=$sessionId',
      'X-CSRFToken': '$csrfToken',
    };
    // pass = 1a2b@b1a2
    var data = {'username': arname, 'password':enname};

    await postData(url, headers, data, csrfToken, sessionId);
    /*
  TODO: Handle the login operation above ^^^^
  DETAILS: When the user successfully logs in, display a pop-up window to indicate success, and vice versa.
  INFO: The server will return {"success": true} or {"success": false, "error": "Invalid credentials"}.
  RECOMMENDED: Take a look at these images:
    --> https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/success.png
    --> https://flutterappdev.com/wp-content/uploads/2019/10/Screen-Shot-2019-10-30-at-4.19.03-PM.jpg
*/
  }

  Future<Map<String, String>> fetchDataAndTokens() async {
    var url = Uri.parse('https://skills.pythonanywhere.com/accounts/log-in/');
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
    var fullUrl = Uri.parse('https://skills.pythonanywhere.com/accounts/api/log-in/');

    // Add the Referer header to satisfy CSRF protection
    headers['Referer'] = 'https://skills.pythonanywhere.com/accounts/log-in/';

    var response = await http.post(
      fullUrl,
      headers: headers,
      body: formData,
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response data: ${response.body}');
      print('Response headers: ${response.headers}');

      /*
      TODO: Fetch sessionid and save it to local storage.
      HINT: Use the same function named --> fetchDataAndTokens
      RECOMMENDED: Modify the function to make it receive an argument --> URL
      RECOMMENDED: Use a secure method to store the sessionid.
    */

    } else {
      print('Failed to send POST request. Status code: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }


/*
  TODO: For testing purposes, send a GET request to the URL https://skills.pythonanywhere.com/accounts/api/check_login/
  INFO: If the response is {"success": true, "user": "roaa"}, then the user is successfully logged in.
        Otherwise, the user is not authenticated.
  REQUIREMENTS: The server needs the cookie 'sessionid' to recognize the user.
*/

//GOODLUCK! :)
/*
  Future<void> addData() async {
  var url = Uri.parse("http://localhost:4000/renew");
  //urlImage = await FirebaseStorageFiles.uploadImage(pickerImage);

  // الحصول على رمز CSRF من خادم Django الخاص بك
  String csrfToken = '...';

  Map<String, String> headers = {
    "Content-type": "application/json",
    "X-CSRFToken": csrfToken,
  };

  Map<String, dynamic> data = {
    'rn_email': c_arnameController,
    'rn_placeOforder': c_ennameController,
    'rn_address': c_phoneController,
    'rn_image': urlImage,
  };

  String requestBody = jsonEncode(data);

  // إجراء طلب POST مع الحقول المحددة ورمز CSRF في الرؤوس
  Response response = await http.post(url, headers: headers, body: requestBody);

  // check the status code for the result
  int statusCode = response.statusCode;

  // this API passes back the id of the new item added to the body
  String body1 = response.body;
  var responseData = jsonDecode(body1);
  print(responseData);

  var res = responseData['code'];

  if (res == null) {
    // handle the response as desired
  }
}

 */

/*
  void fetchDataAndTokens() async {
    var url = Uri.parse('https://skills.pythonanywhere.com/accounts/log-in/');

    // إجراء طلب GET
    var response = await http.get(url);

    // التحقق من رمز الحالة في الاستجابة
    if (response.statusCode == 200) {
      // استخراج ملفات تعريف الارتباط من رأس الاستجابة
      String rawCookieHeader = _parseCookies(response);
      print(rawCookieHeader);
    } else {
      // التعامل مع الأخطاء
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  String _parseCookies(http.Response response) {
    // الحصول على رأس 'set-cookie' من الاستجابة
    String? rawCookieHeader = response.headers['set-cookie'];

    if (rawCookieHeader != null) {
      // قم بتحليل ملفات تعريف الارتباط هنا إذا كانت متوفرة بصورة صحيحة
      List<String> cookies = rawCookieHeader.split(';');
      // يمكنك القيام بعمليات إضافية هنا مع ملفات تعريف الارتباط إذا لزم الأمر
    }

    return rawCookieHeader ?? '';
  }

 */



  String dropdownValue = "";
  String dropdownValue2 = '';
  String dropdownValueS = '';
  String dropdownValuepd = '';
  String dropdownValuepdIraq = '';
  String dropdownValuepdMaritalStatus = '';
  late String place;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  //var image;
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
                          key: _key,
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
                                      textfielBox(c_collegeController, "اسم الجامعه والكليةوالقسم"),
                                      textfielBox(c_graduation_YearController, "سنة التخرج"),
                                     textfielBox(c_start_YearController, "سنة البداية في الجامعة"),
                                      textfielBox(c_cvController, "السيرة الذاتية"),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(25),
                                            child: MaterialButton(
                                              onPressed: () {
                                                _pickImage();
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
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              // تنفيذ الإجراء عندما يكون النموذج صالحًا
                                              setState(() {
                                               //name = c_nameController.text;
                                                //password = c_passwordController.text;
                                                //main();
                                                // place=placeOforder;
                                                // fetchDataAndTokens();
                                              });
                                            }
                                          },


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



