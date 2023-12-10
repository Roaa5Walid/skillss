import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:skillss/bages/jobs/view.dart';
import 'package:skillss/bages/jobs/view2.dart';
import 'package:skillss/dataa.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class Order {
  int id;
  String status;

  Order({required this.id, required this.status});
}
class coursesType {
  int id;
  String name;

  coursesType({required this.id, required this.name});
}
class courses extends StatefulWidget {
  @override
  _coursesState createState() => _coursesState();
}

class _coursesState extends State<courses> {
  List<int>items_per_page=[];
  List<int>idd=[];
  List<String> name = [];
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
  List<coursesType> coursesTypes = [];
  String selectedType = '';
  List<String> filteredWorkshop_choices = [];
  List<int>id=[];


  //List<String> status = [];

  Future<void> getData() async {
    var url = Uri.parse("https://skills.pythonanywhere.com/edu/api/courses/");
    Response response = await get(url);

    String body = response.body;
    Map<String, dynamic> list1 = json.decode(body);


    print(list1);

    setState(() {
      List<dynamic> courses = list1["courses"];
      for (int i = 0; i < courses.length; i++) {
        idd.add(courses[i]["cid"]);
        name.add(courses[i]["name"]);
        priceItems.add(courses[i]["price"]);
        descriptionItems.add(courses[i]["description"]);
        imgItems.add(courses[i]["img"]);
        longdescriptionItem.add(courses[i]["longdescription"]);
        trainerItems.add(courses[i]["trainer"]);
        trainerDescriptionItems.add(courses[i]["trainerDescription"]);
        durationItems.add(courses[i]["duration"]);
        typeItems.add(courses[i]["type"]);
        trainerGenderItems.add(courses[i]["trainerGender"]);
        discount.add(courses[i]["discount"]);
        acceptedItems.add(true);
        selectedItems.add(true);
        //workshopTypes = workshops.map((type) => workshopType(id: type["id"], name: type["name"] ?? "")).toList();

        //removedItems.add(false);
        //status.add(" ");

        if (courses[i]["price"] == 0) {
          priceItems.add(0);
        } else {
          priceItems.add(-1);
        }
      }

    });

    print(list1);
  }


  Future<void> getData2() async {
    var url = Uri.parse("https://skills.pythonanywhere.com/edu/api/courses/");
    Response response = await get(url);

    if (response.statusCode == 200) {
      String body = response.body;
      Map<String, dynamic> data = json.decode(body);

      List<dynamic> types = data["course_choices"];
      for (int i = 0; i < types.length; i++) {
        int value = int.parse(types[i][0].toString());
        String label = types[i][1].toString();
        filteredWorkshop_choices.add(label);
      }

      setState(() {
        // قم بوضع الكود الخاص بتحديث واجهة المستخدم هنا
      });

      print(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }




  @override
  void initState() {
    super.initState();
    getData();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  List<PopupMenuItem<String>> items = filteredWorkshop_choices.map((type) {
                    return PopupMenuItem<String>(
                      value: type  ,
                      child: Text(type ),
                    );
                  }).toList();

                  return items;
                },
                onSelected: (String value) {
                  setState(() {
                    selectedType = value;
                  });
                  print(selectedType);
                },

                child: Row(
                  children: [
                    Icon(Icons.arrow_drop_down,color: Colors.orange,size: 30,),
                    Text(
                      'دورات',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xff041038),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: idd.length,
              itemBuilder: (context, index) {
                if (selectedType != null && selectedType.isNotEmpty && typeItems[index] != selectedType) {
                  return SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child:
                  OrdersBox(
                    name: name[index],
                    price: priceItems[index],
                    description: descriptionItems[index],
                    trainerDescription: trainerDescriptionItems[index],
                    longdescription:longdescriptionItem[index],
                    trainer: trainerItems[index],
                    duration: durationItems[index],
                    type: typeItems[index],
                    trainerGender: trainerGenderItems[index],
                    img: imgItems[index],
                    discount: discount[index],
                    selectedType: selectedType,
                    //typeId: workshopTypes[index].id,
                    //acceptedItems: acceptedItems,
                  ),



                );

              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Jobs()),
                  );
                },
                child: Container(
                  width: 40,height: 40,
                  color: Colors.orange,child:  Center(
                  child: Text("1",
                    style: TextStyle(
                      fontSize:
                      MediaQuery.of(context).size.width * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Jobs2()),
                  );
                },
                child: Container(
                  width: 40,height: 40,
                  color: Colors.orange,child:  Center(
                  child: Text("2",
                    style: TextStyle(
                      fontSize:
                      MediaQuery.of(context).size.width * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}

class OrdersBox extends StatelessWidget {
  final String name;
  final int price;
  final String description;
  final String img;
  final String longdescription;
  final String type;
  final String trainer;
  final String trainerDescription;
  final String duration;
  final String trainerGender;
  //final int typeId;
  final int discount;
  final String selectedType;

  //final String acceptedItems;
  //final String selectedItems;


  OrdersBox({
    required this.name,
    required this.price,
    required this.description,
    required this.longdescription,
    required this.img,
    required this.type,
    required this.trainer,
    required this.trainerDescription,
    required this.duration,
    required this.trainerGender,
    //required this.typeId,
    required this.discount,
    required this.selectedType,
    //required this.acceptedItems,
    //required this.selectedItems,

  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(name: name,price: price,discount: discount,img: img,longdescription: longdescription,trainer: trainer,trainerDescription: trainerDescription,duration: duration,type: type,trainerGender: trainerGender,description: description,selectedType: selectedType,)),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 400,
          decoration: BoxDecoration(
            color: Color(0xff041038),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 9,
                spreadRadius: 7,
                color: Colors.grey.withOpacity(0.6),
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 5,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 9,
                        spreadRadius: 7,
                        color: Colors.grey.withOpacity(0.6),
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      'https://skills.pythonanywhere.com/' + img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Text(
                  textAlign:TextAlign.right,
                  description,
                  style: TextStyle(
                    fontSize:
                    MediaQuery.of(context).size.width * 0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 5,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 4,
                        color: Colors.orange.withOpacity(0.5),
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          trainerGender == 'انثى' ?
                          Icons.female
                              : Icons.male,
                          size:MediaQuery.of(context).size.width * 0.06,color: Colors.orange,
                        ),
                      ),
                      Text(
                        trainer+" "+trainerDescription,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: 100,height: 60,
                        color: Colors.orange.withOpacity(0.5),
                        child: Center(
                          child: Text(  textAlign:TextAlign.right,
                            "$price",
                            style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),

              ],
            ),
          ),
        )


    );
  }
}



class DetailsPage extends StatelessWidget {
  final String name;
  final int price;
  final String description;
  final String img;
  final String longdescription;
  final String type;
  final String trainer;
  final String trainerDescription;
  final String duration;
  final String trainerGender;
  //final int typeId;
  final int discount;
  final String selectedType;

  DetailsPage({
    required this.name,
    required this.price,
    required this.description,
    required this.longdescription,
    required this.img,
    required this.type,
    required this.trainer,
    required this.trainerDescription,
    required this.duration,
    required this.trainerGender,
    // required this.typeId,
    required this.discount,
    required this.selectedType,
    //required this.acceptedItems,
    //required this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff041038),

        appBar: AppBar(
          backgroundColor: Color(0xff041038),
          title: Center(child: Text("تفاصيل الدورة",style: TextStyle(color: Colors.orange),)),
          elevation: 0,
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 9,
                                  spreadRadius: 7,
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),

                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                'https://skills.pythonanywhere.com/' + img,
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.info,color: Colors.white,size: 30,),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(
                                        child: Text('التفاصيل',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,color: Colors.orange),
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "مدة الدورة  :" +duration,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width*0.04,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "نوع الدورة  :" +type,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width*0.04,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "%"+ "الخصم  :" +"$discount",
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width*0.04,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text('إغلاق'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(onPressed: () {email();}, icon: const Icon(Icons.email_outlined,color: Colors.white,size: 30,),),
                            /*
                        IconButton(
                          icon: const Icon(Icons.phone,color: Colors.white,size: 30,),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('التواصل مع معلن الوظيفة',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,color: Colors.orange),
                                  textAlign: TextAlign.right,
                                  ),
                                  content: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  Column(
                                        children: [
                                          Text(
                                            "رقم الهاتف  :" +company_phone,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width*0.04,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          TextButton(onPressed: () {calling();}, child: Text(" Phone call")),
                                          TextButton(onPressed: () {sms();}, child: Text(" Send sms")),
                                          TextButton(onPressed: () {email();}, child: Text(" Send Email")),
                                          TextButton(onPressed: () {whatsapp();}, child: Text(" Whatsapp")),
                                          TextButton(onPressed: () {messenger();}, child: Text(" Facebook messenger")),
                                        ],
                                      ),

                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text('إغلاق'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),

                         */
                            IconButton(
                              icon: const Icon(Icons.phone,color: Colors.white,size: 30,),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('التواصل مع معلن الوظيفة',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,color: Colors.orange),
                                        textAlign: TextAlign.right,
                                      ),
                                      content: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:  Column(
                                            children: [
                                              Text(
                                                "رقم الهاتف  :" +trainerDescription,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width*0.04,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),

                                            ],
                                          ),

                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text('إغلاق'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),


                          ],
                        ),
                        SizedBox(height: 15,),
                        Text(
                          "نبذة تعريفية عن دورة " +name,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width*0.05,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,height: 60,
                              color: Colors.orange.withOpacity(0.5),
                              child: Center(
                                child: Text(  textAlign:TextAlign.right,
                                  "$price",
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              " المدرب : "+trainer,
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.04,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          longdescription,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width*0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),

                      ],
                    ),
                  );

                },
              ),
            ),
          ],
        )
    );
  }
  calling()async{
    const url = 'tel:+9647705458521';
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  whatsapp()async{
    const url = "whatsapp://send?phone=+9647705458521";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  messenger()async{
    const url = "http://m.me/xyzchannelxyz";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  sms()async{
    const url = 'sms:+9647705458521';

    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  Future<void> email() async {
    final Uri _emailUrl = Uri(
      scheme: 'mailto',
      path: trainer,
      queryParameters: {'subject': 'Hello'},
    );

    if (await canLaunchUrlString(_emailUrl.toString())) {
      await launchUrlString(_emailUrl.toString());
    } else {
      throw 'Could not launch $_emailUrl';
    }
  }

}


/*
Future<void> getData2() async {
    var url = Uri.parse("https://skills.pythonanywhere.com/jobs/api");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String body = response.body;
      Map<String, dynamic> data = json.decode(body);

      setState(() {
        List<dynamic> jobs = data["jobs"];
        jobTypes = jobs.map((type) => JobType(id: type["id"], name: type["name"] ?? "")).toList();
      });
    } else {
      print("Failed to fetch data");
    }
  }
 */