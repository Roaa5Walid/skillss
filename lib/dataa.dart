


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

var nameup="";
var phoneup ="";
var passwordup="";

var name="";
var phonee ="";
var password="";


var arname="";
var enname ="";
var phone="";

Padding textfielBox(TextEditingController Controllerr,String hintt){
  return Padding(
    padding: const EdgeInsets.all(7),
    child: TextFormField(
      controller: Controllerr,
      maxLength: 50,
      cursorColor: Color(0xffffffff),
      style: const TextStyle(color: Colors.black,fontFamily: "Cairo"),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              )),
          labelText:hintt,
          hintText: hintt,

          //suffixStyle: TextStyle(fontSize: 40)
        ),

      validator: (value) {
        if (value!.isEmpty) {
          return 'يجب ملء هذا الحقل';
        }
        return null;
      },
    ),
  );
}




Center listText(BuildContext context, String listName, Widget nav) {
  return Center(
    child: ListTile(
      title: Center(
        child: Text(
          listName,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            color: Colors.orange,
            fontFamily: "Cairo",
          ),
        ),
      ),
      onTap: () {
        // اتخذ الإجراء المناسب عند النقر على العنصر الأول
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => nav,
        ));
      },
    ),
  );
}
//forms

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
String dropdownValue = "";

///text style
class dataaa extends StatefulWidget {
  const dataaa({super.key});

  @override
  State<dataaa> createState() => _dataaaState();
}

class _dataaaState extends State<dataaa> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  TextStyle textStylePages(int col){
    return TextStyle(
      fontSize:  MediaQuery.of(context).size.width * 0.04,
      color: Color(col),
      fontWeight: FontWeight.bold,
      fontFamily: "Cairo",

    );
  }
}

class MyTextStyles {
  static TextStyle textStylePages(BuildContext context, int col) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      color: Color(col),
      fontWeight: FontWeight.bold,
      fontFamily: "Cairo",
    );
  }
}
List<int>items_per_page=[];
List<int>idd=[];
//List<String> name = [];
List<int> priceItems = [];
List<String> descriptionItems = [];
List<String> imgItems = [];
List<String> longdescriptionItem = [];
List<String> trainerItems = [];
List<String> trainerDescriptionItems = [];
List<String> durationItems = [];
List<String> typeItems = [];
List<String> trainerGenderItems = [];
List<int>discount=[];
List<bool> acceptedItems = [];
List<bool> selectedItems = [];
//List<workshopType> workshopTypes = [];
String selectedType = '';
List<String> filteredWorkshop_choices = [];
List<int>id=[];
