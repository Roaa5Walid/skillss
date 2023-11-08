import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class Order {
  int id;
  String status;

  Order({required this.id, required this.status});
}
class JobType {
  int id;
  String name;

  JobType({required this.id, required this.name});
}
class Jobs extends StatefulWidget {
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  List<int>items_per_page=[];
  List<int>idd=[];
  List<String> titleItems = [];
  List<int> salaryItems = [];
  List<String> descriptionItems = [];
  List<String> about_employerItem = [];
  List<String> typeItems = [];
  List<String> company_nameItems = [];
  List<String> company_locationItems = [];
  List<String> company_phoneItems = [];
  List<String> company_emailItems = [];
  List<String> imgItems = [];
  List<bool> acceptedItems = [];
  List<bool> selectedItems = [];
  List<JobType> jobTypes = [];
  String selectedType = '';


  //List<String> status = [];

  Future<void> getData() async {
    var url = Uri.parse("https://skills.pythonanywhere.com/jobs/api");
    Response response = await get(url);

    String body = response.body;
    Map<String, dynamic> list1 = json.decode(body);


    print(list1);

    setState(() {
      List<dynamic> jobs = list1["jobs"];
      for (int i = 0; i < jobs.length; i++) {
        items_per_page.add(jobs[i]["items_per_page"] ?? 0);
        idd.add(jobs[i]["id"]);
        titleItems.add(jobs[i]["title"]);
        salaryItems.add(jobs[i]["salary"]);
        descriptionItems.add(jobs[i]["description"]);
        about_employerItem.add(jobs[i]["about_employer"]);
        typeItems.add(jobs[i]["type"]);
        company_nameItems.add(jobs[i]["company_name"]);
        company_locationItems.add(jobs[i]["company_location"]);
        company_phoneItems.add(jobs[i]["company_phone"]);
        company_emailItems.add(jobs[i]["company_email"]);
        imgItems.add(jobs[i]["img"]);
        descriptionItems.add(jobs[i]["description"]);
        acceptedItems.add(true);
        selectedItems.add(true);
        jobTypes = jobs.map((type) => JobType(id: type["id"], name: type["name"] ?? "")).toList();

        //removedItems.add(false);
        //status.add(" ");

        if (jobs[i]["salary"] == 0) {
          salaryItems.add(0);
        } else {
          salaryItems.add(-1);
        }
      }
    });

    print(list1);
  }




  @override
  void initState() {
    super.initState();
    getData();
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
                  List<PopupMenuItem<String>> items = typeItems.map((type) {
                    return PopupMenuItem<String>(
                      value: type,
                      child: Text(type),
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
                      'الوظائف',
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
              itemCount: titleItems.length,
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
                        title: titleItems[index],
                        salary: salaryItems[index],
                        description: descriptionItems[index],
                        company_name: company_nameItems[index],
                          about_employer:about_employerItem[index],
                        type: typeItems[index],
                        company_location: company_locationItems[index],
                        company_phone: company_phoneItems[index],
                        company_email: company_emailItems[index],
                        img: imgItems[index],
                        selectedType: selectedType,
                        typeId: jobTypes[index].id,
                        //acceptedItems: acceptedItems,
                      ),



                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersBox extends StatelessWidget {
  final String title;
  final int salary;
  final String description;
  final String company_name;
  final String about_employer;
  final String type;
  final String company_location;
  final String company_phone;
  final String company_email;
  final String img;
  final int typeId;
  final String selectedType;

  //final String acceptedItems;
  //final String selectedItems;


  OrdersBox({
    required this.title,
    required this.salary,
    required this.description,
    required this.company_name,
    required this.about_employer,
    required this.type,
    required this.company_location,
    required this.company_phone,
    required this.company_email,
    required this.img,
    required this.typeId,
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
          MaterialPageRoute(builder: (context) => DetailsPage(img: img,selectedType: selectedType,typeId: typeId,company_email: company_email,company_phone: company_phone,company_location: company_location,type: type,company_name: company_name,about_employer: about_employer,description: description,salary: salary,title: title,)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 300,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 5,
              height: 150,
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
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://skills.pythonanywhere.com/' + img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                company_name,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                bottom: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "العنوان الوظيفي : $title",
                      style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.width * 0.04,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " الراتب : ${salary == 0 ? 'يحدد بعد المقابلة' : salary.toString()}",
                      style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.width * 0.04,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )


    );
  }
}



class DetailsPage extends StatelessWidget {
  final String title;
  final int salary;
  final String description;
  final String company_name;
  final String about_employer;
  final String type;
  final String company_location;
  final String company_phone;
  final String company_email;
  final String img;
  final int typeId;
  final String selectedType;

  DetailsPage({
    required this.title,
    required this.salary,
    required this.description,
    required this.company_name,
    required this.about_employer,
    required this.type,
    required this.company_location,
    required this.company_phone,
    required this.company_email,
    required this.img,
    required this.typeId,
    required this.selectedType,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff041038),

        appBar: AppBar(
        backgroundColor: Color(0xff041038),
        title: Center(child: Text("تفاصيل الوظيفة",style: TextStyle(color: Colors.orange),)),
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
                                  title: Text('معلومات عن الجهة المقدمة للوضيفه',style:TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,color: Colors.orange),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "اسم الجهة  :" +company_name,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width*0.04,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                company_location,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width*0.04,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Icon(Icons.location_on_outlined,color: Colors.orange,),
                                            ],
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
                                            "رقم الهاتف  :" +company_phone,
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
                        "العنوان الوظيفي :" +title,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.05,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      " الراتب : ${salary == 0 ? 'يحدد بعد المقابلة' : salary.toString()}",
                      style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.width * 0.04,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                        "الوصف الوظيفي :" +description,
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
      path: company_email,
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