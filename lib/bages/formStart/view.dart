import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'dart:io' as io;

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;


var c_arnameController = TextEditingController();
var c_ennameController = TextEditingController();
var c_phoneController = TextEditingController();
var c_emailController = TextEditingController();
var c_addressController = TextEditingController();

var c_month_birthController = TextEditingController();
var c_day_birthController = TextEditingController();
var c_yearController = TextEditingController();

var c_courseController = TextEditingController();
var c_expertiseController = TextEditingController();
var c_collegeController = TextEditingController();
var c_start_YearController = TextEditingController();
var c_graduation_YearController = TextEditingController();
var c_cvController = TextEditingController();
var c_hGraduationController = TextEditingController();

var c_imageController = TextEditingController();
var c_image2Controller = TextEditingController();

class FormStart extends StatefulWidget {
  const FormStart({Key? key}) : super(key: key);

  @override
  State<FormStart> createState() => _FormStartState();
}

class _FormStartState extends State<FormStart> {
  String? urlImage;
  PickedFile? pickerImage;
  String status = "";
  /*
  Future Add_data() async {
    var url = Uri.parse("http://localhost:4000/renew");
    //urlImage = await FirebaseStorageFiles.uploadImage(pickerImage);
    Map<String, String> headers = {"Content-type": "application/json"};

    String json = '{"rn_email": "$email",'
        ' "rn_placeOforder": "$placeOforder",'
        ' "rn_typeOfmarrige": "$typeOfmarrige",'
        ' "rn_sex": "$sex",'
        ' "rn_placeOfbirth": "$placeOfbirth",'
        ' "rn_firstname": "$firstname",'
        ' "rn_fathersName": "$fathersName",'
        ' "rn_grandfatherName": "$grandfatherName",'
        ' "rn_surname": "$surname",'
        ' "rn_motherName": "$motherName",'
        ' "rn_motherFather": "$motherFather",'
        ' "rn_provinceCountry": "$provinceCountry",'
        ' "rn_maritalStatus": "$maritalStatus",'
        ' "rn_profession": "$profession",'
        ' "rn_dateOfbirth": "$dateOfbirth",'
        ' "rn_nationaliIDNumber": "$nationaliIDNumber",'
        ' "rn_phone": "$phone",'
        ' "rn_address": "$address",'
        ' "rn_image": "$urlImage"}';
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



  String dropdownValue = "";
  String dropdownValue2 = '';
  String dropdownValueS = '';
  String dropdownValuepd = '';
  String dropdownValuepdIraq = '';
  String dropdownValuepdMaritalStatus = '';
  late String place;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  //var image;
  io.File? imageFile;
  final imagepicked = ImagePicker();
  uploadImage() async {
    var pickedimage = await imagepicked.getImage(source: ImageSource.gallery);
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
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                            )),
                        child: Form(
                          key: _key,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int i) {
                                return Column(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_arnameController,
                                        validator: (c_arnameController) {
                                          if (c_arnameController != null &&
                                              c_arnameController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"الاسم الثلاثي بالعربي",
                                          hintText:
                                          "الاسم الثلاثي بالعربي",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_ennameController,
                                        validator: (c_ennameController) {
                                          if (c_ennameController != null &&
                                              c_ennameController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"الاسم الثلاثي بالانكليزي",
                                          hintText:
                                          "الاسم الثلاثي بالانكليزي",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
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
                                                Radius.circular(15),
                                              )),
                                          labelText:"رقم الهاتف",
                                          hintText:
                                          "رقم الهاتف",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_emailController,
                                        validator: (c_emailController) {
                                          if (c_emailController != null &&
                                              c_emailController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"البريد الالكتروني",
                                          hintText:
                                          "البريد الالكتروني",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_addressController,
                                        validator: (val) {
                                          if (val != null && val.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"عنوانالسكن",
                                          hintText:"عنوانالسكن",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_day_birthController,
                                        validator: (c_day_birthController) {
                                          if (c_day_birthController != null &&
                                              c_day_birthController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"يوم المولد",
                                          hintText:
                                          "يوم المولد",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_month_birthController,
                                        validator: (c_month_birthController) {
                                          if (c_month_birthController != null &&
                                              c_month_birthController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"شهر المولد",
                                          hintText:
                                          "شهر المولد",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_yearController,
                                        validator: (c_yearController) {
                                          if (c_yearController != null &&
                                              c_yearController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"سنة المولد",
                                          hintText:
                                          "سنة المولد",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_courseController,
                                        validator: (c_courseController) {
                                          if (c_courseController != null &&
                                              c_courseController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"اسم الكورسات والتدريبات ان وجدت",
                                          hintText:
                                          "اسم الكورسات والتدريبات ان وجدت",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_collegeController,
                                        validator: (c_collegeController) {
                                          if (c_collegeController != null &&
                                              c_collegeController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"اسم الجامعه والكليةوالقسم",
                                          hintText:
                                          "اسم الجامعة والكلية والقسم",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_graduation_YearController,
                                        validator: (c_graduation_YearController) {
                                          if (c_graduation_YearController != null &&
                                              c_graduation_YearController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"سنة التخرج",
                                          hintText:
                                          "سنة التخرج",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_start_YearController,
                                        validator: (c_start_YearController) {
                                          if (c_start_YearController != null &&
                                              c_start_YearController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"سنة البداية في الجامعة",
                                          hintText:
                                          "سنة البداية في الجامعة",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: c_cvController,
                                        validator: (c_cvController) {
                                          if (c_cvController != null &&
                                              c_cvController.isEmpty) {
                                            return "requiredField";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          labelText:"السيرة الذاتية",
                                          hintText:
                                          "السيرة الذاتية",
                                          //suffixStyle: TextStyle(fontSize: 40)
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
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
                                    /*
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
                                    */


                                    Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        /*
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationDone(status: status,u_phone: phone,)));
                                          setState(() {
                                            email = c_emailController.text;
                                            firstname =
                                                c_firstnameController.text;
                                            fathersName =
                                                c_fathersNameController.text;
                                            grandfatherName =
                                                c_grandfatherNameController
                                                    .text;
                                            surname = c_surnameController.text;
                                            motherName =
                                                c_motherNameController.text;
                                            motherFather =
                                                c_motherFatherController.text;
                                            provinceCountry =
                                                c_provinceCountryController
                                                    .text;
                                            maritalStatus =
                                                c_maritalStatusController.text;
                                            profession =
                                                c_professionController.text;
                                            dateOfbirth =
                                                c_dateOfbirthController.text;
                                            nationaliIDNumber =
                                                c_nationaliIDNumberController
                                                    .text;
                                            phone = c_phoneController.text;
                                            address = c_addressController.text;
                                            placeOforder = dropdownValue;
                                            typeOfmarrige = dropdownValue2;
                                            sex = dropdownValueS;
                                            placeOfbirth = dropdownValuepd;
                                            provinceCountry =
                                                dropdownValuepdIraq;
                                            maritalStatus =
                                                dropdownValuepdMaritalStatus;

                                            //place=placeOforder;
                                            Add_data();
                                          });
                                        },

                                         */
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



