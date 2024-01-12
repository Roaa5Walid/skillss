import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:skillss/dataa.dart';


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class CreateCV2 extends StatefulWidget {
  const CreateCV2({super.key});

  @override

  State<CreateCV2> createState() => _CreateCV2State();
}

class _CreateCV2State extends State<CreateCV2> {
  @override
  void initState() {
    super.initState();
  }

  String status = "";
  String dropdownValue = "AR"; // Default language value

  late XFile? _imageFile = null  ;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = (await picker.pickImage(source: ImageSource.camera));

      if (image != null) {
        //final filePath = image.path; // Get the file path from XFile
        //_imageFile = File(filePath) as XFile; // Create a File object from the path
        setState(() {
          _imageFile = image ;
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }

  }


  Future<void> sendCv({
    required String url,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String address,
    required String universityInfo,
    required String universityStartYear,
    required String universityGraduationYear,
    required String birthDay,
    required String birthMonth,
    required String birthYear,
    required String language,
    required File imageFile,
    required String coursesAndTraining,
    required String workExperience,
  }) async {
    try {

      // Fetch CSRF token
      var csrfResponse = await http.get(Uri.parse(url));
      if (csrfResponse.statusCode != 200) {
        throw Exception('Failed to fetch CSRF token');
      }
      var csrfToken = csrfResponse.headers['set-cookie']?.split(';')?.firstWhere((cookie) => cookie.startsWith('csrftoken='))?.split('=')?.last;
      if (csrfToken == null) {
        throw Exception('Failed to fetch CSRF token');
      }

      // Fetch CSRF token and session ID
      var result = await fetchDataAndTokens();
       csrfToken = result['csrfToken']!;
      var sessionId = result['sessionId']!;

      var headers = {
        'Content-Type': 'multipart/form-data', // Use multipart/form-data for image uploads
        'Cookie': 'csrftoken=$csrfToken;  sessionid=$sessionId',
        'X-CSRFToken': '$csrfToken',
        'Referer': 'https://www.skillsiraq.com/edu/make_cv/',
      };


      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      request.headers['Referer'] = url;
      request.headers['X-CSRFToken'] = csrfToken;
      request.headers['Cookie'] = 'csrftoken=$csrfToken';


      /*
      request.fields['full_name'] = fullName;
      request.fields['phone_number'] = phoneNumber;
      request.fields['email'] = email;
      request.fields['address'] = address;
      request.fields['university_info'] = universityInfo;
      request.fields['university_start_year'] = universityStartYear;
      request.fields['university_graduation_year'] = universityGraduationYear;
      request.fields['birth_day'] = birthDay;
      request.fields['birth_month'] = birthMonth;
      request.fields['birth_year'] = birthYear;
      request.fields['language'] = language;
      request.fields['courses_and_training'] = coursesAndTraining;
      request.fields['work_experience'] = workExperience;

       */
      // Add form fields
      var data = {
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "address": address,
        "university_info": universityInfo,
        "university_start_year": universityStartYear,
        "university_graduation_year": universityGraduationYear,
        "birth_day": birthDay,
        "birth_month": birthMonth,
        "birth_year": birthYear,
        "language": language,
        "courses_and_training": coursesAndTraining,
        "work_experience": workExperience,
      };
      request.fields.addAll(data);

      if (_imageFile != null) {
        var imageStream = http.ByteStream(_imageFile!.openRead()); // Use _imageFile!.openRead()
        var imageLength = await _imageFile!.length();

        request.files.add(http.MultipartFile(
          'img',
          imageStream,
          imageLength,
          filename: _imageFile!.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ));
      }


      var response = await request.send();
// Get the response
      var responseString = await response.stream.bytesToString();

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


  void main() async {
   // File imageFile = _imageFile as File;
    await sendCv(
      url: 'https://www.skillsiraq.com/edu/make_cv/',
      fullName: c_arnameController.text,
      phoneNumber: c_phoneController.text,
      email: c_emailController.text,
      address: c_addressController.text,
      universityInfo: universityInfoController.text,
      universityStartYear: universityStartYearController.text,
      universityGraduationYear: universityGraduationYearController.text,
      birthDay: c_day_birthController.text,
      birthMonth: c_month_birthController.text,
      birthYear: c_yearController.text,
      language: dropdownValue, // or EN for english
      imageFile:  File(_imageFile!.path) , // Check for null before conversion
      coursesAndTraining: c_courseController.text,
      workExperience: c_workExperienceController.text,
    );
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
                                    PhoneFieldBox(c_phoneController, "رقم الهاتف"),
                                    textfielBox(c_emailController, "البريد الالكتروني"),
                                    textfielBox(c_addressController, "عنوانالسكن"),
                                    textfielBox(universityInfoController, "اسم الجامعة والكلية والقسم"),
                                    textfielBox(universityStartYearController, "سنة البداية في الجامعة"),
                                    textfielBox(universityGraduationYearController, "سنة التخرج"),
                                    textfielBox(c_day_birthController, "يوم المولد"),
                                    textfielBox(c_month_birthController, "شهر المولد"),
                                    textfielBox(c_yearController, "سنة المولد"),
                                    textfielBox(c_courseController, "اسم الكورسات والتدريبات ان وجدت"),
                                    textfielBox(c_workExperienceController, "الخبرة العملية اذا كنت تعمل سابقا"),

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
                                                Text("اللغة",
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
                                                     "AR",
                                                      "EN"
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

                                                            onTap: () => print("Language selected: $value"), // Example action on tap
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
                                        color: Colors.white12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: ElevatedButton(
                                        onPressed: () async{
                                  if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _imageFile!.path;
                                            print(_imageFile!.path);
                                            main();
                                            /*
                                            sendCv(url: 'https://www.skillsiraq.com/edu/make_cv/',
                                              fullName: c_arnameController.text,
                                              phoneNumber: c_phoneController.text,
                                              email: c_emailController.text,
                                              address: c_addressController.text,
                                              universityInfo: universityInfoController.text,
                                              universityStartYear: universityStartYearController.text,
                                              universityGraduationYear: universityGraduationYearController.text,
                                              birthDay: c_day_birthController.text,
                                              birthMonth: c_month_birthController.text,
                                              birthYear: c_yearController.text,
                                              language: dropdownValue, // or EN for english
                                              imageFile:  File(_imageFile!.path) , // Check for null before conversion
                                              coursesAndTraining: c_courseController.text,
                                              workExperience: c_workExperienceController.text,);

                                             */
                                          });
                                          /*
            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
            setState(() {
            main();
            });
            }

                                           */
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
    );  }
}
