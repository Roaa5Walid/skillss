import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class CreateCV3 extends StatefulWidget {
  const CreateCV3({super.key});

  @override
  State<CreateCV3> createState() => _CreateCV3State();
}

class _CreateCV3State extends State<CreateCV3> {
  @override
  void initState() {
    super.initState();
    main(); // Ensuring main() is called on initialization
  }

  String status = "";

  late XFile _imageFile = XFile(""); // Initializing _imageFile

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera); // Picking image from camera

      if (image != null) {
        setState(() {
          _imageFile = image; // Updating _imageFile with selected image
        });
        main(); // Calling main() after image selection
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> main() async {
    try {
      if (_imageFile == null || _imageFile.path.isEmpty) { // Checking if image file is null or path is empty
        print('No image file or invalid path');
        return;
      }

      // Fetch CSRF token and session ID
      var result = await fetchDataAndTokens(); // Fetching CSRF token and session ID
      var csrfToken = result['csrfToken']!;
      var sessionId = result['sessionId']!;

      // Server URL and headers
      var url = Uri.parse('https://www.skillsiraq.com/edu/make_cv/');
      var headers = {
        'Content-Type': 'multipart/form-data', // Changed Content-Type to multipart/form-data
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
        var image = await http.MultipartFile.fromPath("image", _imageFile.path); // Adding image to request
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
      Map<String, String> cookies = _parseCookies(response); // Parsing cookies

      String csrfToken = cookies['csrftoken'] ?? ''; // Extracting CSRF token
      String sessionId = cookies['sessionid'] ?? ''; // Extracting session ID

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

      RegExp regex = RegExp(r'(\w+)=([^;]+);'); // Changed regex to capture full cookie value
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
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          await _pickImage(); // Picking image
                                        },
                                        height: 50,
                                        shape: const StadiumBorder(),
                                        color:
                                            Colors.white.withOpacity(0.7),
                                        child: Center(
                                          child: Text(
                                            "placePhoto",
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
                                      child: _imageFile.path.isEmpty
                                          ? Text('No image selected.') // Check if image is selected
                                          : Image.file(
                                              File(_imageFile.path),
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
                                    onPressed: () async {
                                      setState(() {
                                        _imageFile.path; // Accessing image file path
                                        main(); // Calling main()
                                      });
                                    },
                                    child: Text(
                                      "next",
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
                          },
                        ),
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
