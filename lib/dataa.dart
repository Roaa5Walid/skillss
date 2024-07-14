
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      style: const TextStyle(color: Colors.black,fontFamily: "Cairo",),
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

Widget PhoneFieldBox(TextEditingController controller, String hintText) {
  return Padding(
    padding: const EdgeInsets.all(7.0),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone, // Set keyboard type for phone numbers
      maxLength: 15, // Adjust based on your phone number format
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.black, fontFamily: "Cairo"),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        labelText: hintText,
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'يجب ملء هذا الحقل'; // "This field is required" in Arabic
        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'الرجاء إدخال رقم هاتف صالح'; // "Please enter a valid phone number" in Arabic
        }
        return null;
      },
    ),
  );
}


///Home page
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

// دالة لإنشاء أيقونة مع مؤثرات
Widget createIcon(IconData icon, Color color) {
  return ColorFiltered(
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    child: Icon(icon),
  );
}
GestureDetector homeBox(BuildContext context,String name,Widget Function() nav){
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => nav()));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.5,
        height: 130.0, // Set a fixed height

        decoration: BoxDecoration(
          color: Color(0xff041038),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.white,
              // offset: Offset(5, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Icon(Icons.add_box,size: 30,weight: 30,color: Colors.white,),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  name,
                  style: MyTextStyles.textStylePages(context, Colors.orange.value,),
                ),
              ),
            ),


          ],
        ),

      ),
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
var c_languageController = TextEditingController();
var c_imageController = TextEditingController();
var c_hGraduationController = TextEditingController();

var email = "";
var address = "";
var month_birth = "";
var day_birth = "";
var year = "";
var course="";
var expertise="";
var college="";
var start_Year="";
var graduation_Year="";
var cv="";
var language="";

var c_image = "";
String dropdownValue = "";
///universty inf form
var universityNameController = TextEditingController();
var universityLocationController = TextEditingController();
var yearFoundedController = TextEditingController();
var numberOfStudentsController = TextEditingController();
var universityEmailController = TextEditingController();
var universityDescriptionController = TextEditingController();
var universityNeedsController = TextEditingController();
var universityName="";
var universityLocation="";
var yearFounded="";
var numberOfStudents="";
var universityEmail="";
var universityDescription="";
var universityNeeds="";


var universityStartYearController=TextEditingController() ;
var universityGraduationYearController=TextEditingController();
var universityInfoController = TextEditingController();

var c_workExperienceController=TextEditingController();

///company inf form
var companyNameController = TextEditingController();
var companyLocationController = TextEditingController();
var companyCategoryController = TextEditingController();
var SpecializationController = TextEditingController();
var companyEmailController = TextEditingController();
var companyDescriptionController = TextEditingController();
var companyNeedsController = TextEditingController();
var companyName= "";
var companyLocation = "";
var companyCategory = "";
var Specialization = "";
var companyEmail = "";
var companyDescription = "";
var companyNeeds = "";

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
      fontSize: 15,
      color: Color(col),
      fontWeight: FontWeight.bold,
      fontFamily: "Cairo",
    );
  }
}

class beTextStyles {
static TextStyle textStylePages(BuildContext context, int col) {
return TextStyle(
fontSize: MediaQuery.of(context).size.width * 0.05,
color: Color(col),
fontWeight: FontWeight.bold,
fontFamily: "beINNormal",
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

Row pagesArrow(BuildContext context,Widget Function() nav,Widget Function() nav2){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => nav()));
        },
        child: Container(
          width: 40,
          height: 40,
          color:Color(0xff041038),
          child: Center(
            child: Text(
              "◀", // رمز السهم للأعلى
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 5),
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => nav2()));
        },
        child: Container(
          width: 40,
          height: 40,
          color: Color(0xff041038),
          child: Center(
            child: Text(
              "▶", // رمز السهم للأسفل
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
