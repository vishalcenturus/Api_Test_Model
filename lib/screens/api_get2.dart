import 'dart:convert';
import 'package:api_tester/screens/post_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetSpecificData extends StatefulWidget {
  const GetSpecificData({Key? key}) : super(key: key);

  @override
  State<GetSpecificData> createState() => _GetSpecificDataState();
}

class _GetSpecificDataState extends State<GetSpecificData> {
  var stringResponse = '';
  List ApiData = [];

  

  Future apicall() async {
    var response;
    response = await http.get(Uri.parse(
        "http://65.0.74.155:8000/users/appoinments/?user_id=73462a2e-e1b4-449a-9de9-a2e5fb43aa8e"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body.toString();
        ApiData = jsonDecode(stringResponse);
      });
      print(ApiData);
    }
  }
   

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Demo"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: width,
              height: height / 1.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red.withOpacity(0.3)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: ApiData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                               "USER:-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(ApiData[index]['user']['id'].toString()),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "MENTOR:-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(ApiData[index]['mentor']['id'].toString() +
                                '\n' +
                                ApiData[index]['mentor']['name'].toString() +
                                '\n ' +
                                ApiData[index]['mentor']['email'].toString()),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Mentor_Plan:-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(ApiData[index]['mentor_plan']['id']
                                    .toString() +
                                '\n' +
                                ApiData[index]['mentor_plan']['plan_name']
                                    .toString() +
                                '\n' +
                                ApiData[index]['mentor_plan']
                                        ['meeting_duration']
                                    .toString() +
                                '\n' +
                                ApiData[index]['mentor_plan']['charges']
                                    .toString()),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckPostApi(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: width / 2,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


