import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  String message = "";
  String status = "";
  List<dynamic> data = [];

  Future<void> getData() async {
    try {
      var url = Uri.parse("https://skills.pythonanywhere.com/jobs/api_test");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> responseData = json.decode(body);
        print("responseData");

        setState(() {
          message = responseData["message"];
          status = responseData["status"];
          data = List<dynamic>.from(responseData["data"]);
        });
      } else {
        print("Failed to fetch data. Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
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
      appBar: AppBar(
        title: Text("Your Widget"),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                "Data: ${data[index].toString()}",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }
}