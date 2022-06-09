import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CheckPostApi extends StatefulWidget {
  const CheckPostApi({Key? key}) : super(key: key);

  @override
  State<CheckPostApi> createState() => _CheckPostApiState();
}

class _CheckPostApiState extends State<CheckPostApi> {
  TextEditingController meetingdatetimeController = TextEditingController();
  TextEditingController meetingpurposeController = TextEditingController();
  TextEditingController durationController  = TextEditingController();


  Future<http.Response> postRequest(BuildContext context, meeting_datetime, meeting_purpose, duration ) async {
    var url = 'http://65.0.74.155:8000/users/appoinments/';


    var response = await http.post(Uri.parse(url),
        body: {'mentor_id': "be3da8d3-1072-442c-a24d-48360a60ba97",
         'user_id': "73462a2e-e1b4-449a-9de9-a2e5fb43aa8e",
           'mentor_plan_id': '0e03d91d-115b-4233-9b8e-430351f57b0c',
            'meeting_datetime': meetingdatetimeController.text,
             'meeting_purpose': meetingpurposeController.text, 
             'duration': durationController.text});
    var jsonResponse = (response.body);
    print(jsonResponse);
if(!jsonResponse.isEmpty){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(" API POST SUCCESSFULLY"))
    );
    meetingdatetimeController.text="";
    meetingpurposeController.text = "";
    durationController.text = "";
}
    return response;

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Api Demo"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Enter Meeting Datetime',
                ),
                controller: meetingdatetimeController ,
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: ' Enter Meeting Purpose',
                ),
                controller: meetingpurposeController,
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Enter duration',
                ),
                controller: durationController,
              ),
              ElevatedButton(
                onPressed: () => postRequest(
                  context,
                  meetingdatetimeController.text,
                  meetingpurposeController.text,
                  durationController.text
                ),
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
