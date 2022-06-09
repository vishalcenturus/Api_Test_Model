import 'package:api_tester/screens/api_get2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Getapi extends StatefulWidget {
  const Getapi({Key? key}) : super(key: key);

  @override
  State<Getapi> createState() => _GetapiState();
}

class _GetapiState extends State<Getapi> {
  String stringResponse = '';

  Future apicall() async {
    http.Response response;
    response = await http
        .get(Uri.parse("http://65.0.74.155:8000/users/appoinments/?user_id=73462a2e-e1b4-449a-9de9-a2e5fb43aa8e"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
      });
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
        title: Center(
          child: Text("Api Demo"),
        ),
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
                  child: Text(
                    stringResponse.toString(),
                  ),
                ),
              ),
            ),
          ),
          
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GetSpecificData() ));
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
