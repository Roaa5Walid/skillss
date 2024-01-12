import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:skillss/dataa.dart';
import 'package:http/http.dart' as http;

import '../home/view.dart';
import '../signup/view.dart';

const newstatus2="0";
var c_nameController = TextEditingController();
var c_phoneController = TextEditingController();
var c_passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  /*
}
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

   */
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
    var data = {'username': name, 'password':password};

    await postData(url, headers, data, csrfToken, sessionId);
    /*
  TODO: Handle the login operation above ^^^^
  DETAILS: When the user successfully logs in, display a pop-up window to indicate success, and vice versa.
  INFO: The server will return {"success": true} or {"success": false, "error": "Invalid credentials"}.
  RECOMMENDED: Take a look at these images:
    --> https://raw.githubusercontent.com/Arbaz-Softagics/commons/master/screenshots/success.png
    --> https://flutterappdev.com/wp-content/uploads/2019/10/Screen-Shot-2019-10-30-at-4.19.03-PM.jpg
*/
     await postData(url, headers, data, csrfToken, sessionId);

    // Use the response variable inside the setState callback

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
    setState(() {
      // Check the response from the server for successful login
      if (response.body.contains('"success": true')) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => signup()));
      }
    });
  }


/*
  TODO: For testing purposes, send a GET request to the URL https://skills.pythonanywhere.com/accounts/api/check_login/
  INFO: If the response is {"success": true, "user": "roaa"}, then the user is successfully logged in.
        Otherwise, the user is not authenticated.
  REQUIREMENTS: The server needs the cookie 'sessionid' to recognize the user.
*/

//GOODLUCK! :)

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
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يجب ملء هذا الحقل';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        TextFormField(
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
                            hintText: "password",
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'يجب ملء هذا الحقل';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        ///

                        ///
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  child: Text(
                                    "اذا لم يكن لديك حساب اضغط هنا لانشاء حساب جديد",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => signup()));
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: ElevatedButton(
              onPressed: () {
              if (_formKey.currentState!.validate()) {
              // تنفيذ الإجراء عندما يكون النموذج صالحًا
              setState(() {
               name = c_nameController.text;
              password = c_passwordController.text;
              main();
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
            },
          ),
        ),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ... (other imports)

const newstatus2 = "0";

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  var c_nameController = TextEditingController();
  var c_phoneController = TextEditingController();
  var c_passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve saved data, if any
      c_nameController.text = prefs.getString('username') ?? '';
      c_phoneController.text = prefs.getString('phone') ?? '';
      c_passwordController.text = prefs.getString('password') ?? '';
    });
  }

  _saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', c_nameController.text);
    prefs.setString('phone', c_phoneController.text);
    prefs.setString('password', c_passwordController.text);
  }

  // ... (other methods)

  Future<void> postData(Uri url, Map<String, String> headers, Map<String, dynamic> formData, String csrfToken, String sessionId) async {
    // ... (existing code)

    // Save form data after successful login
    _saveFormData();
  }

  // ... (existing code)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (existing code)

      ElevatedButton(
        onPressed: () async {
          // ... (existing code)

          // Save form data before making the HTTP request
          _saveFormData();

          // ... (existing code)
        },
        // ... (existing code)
      )
    );
  }
}

 */