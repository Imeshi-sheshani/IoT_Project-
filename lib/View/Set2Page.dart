import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slt_power_prox_new/MyHomePage.dart';
import 'package:slt_power_prox_new/View/ViewBattery.dart';

class Set2Page extends StatefulWidget {
  String setID1;
  String setID2;

  Set2Page({super.key, required this.setID1, required this.setID2});

  Set2PageState createState() => Set2PageState();
}

class Set2PageState extends State<Set2Page> {
  bool _dataLoaded = false;
  List<dynamic> _dataList = [];
  bool _matchFound = false;
  Map<String, dynamic> _matchedStation1 = {};
  Map<String, dynamic> _matchedStation2 = {};

  void initState() {
    super.initState();
    _fetchBatterySet();
  }

  ListTile makeListTile(String subjectName, String? variable) =>
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
            border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white),
            ),
          ),
          child: Text(
            subjectName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          variable ?? 'N/A',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );

  Card makeCard(Lesson lesson) =>
      Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: SizedBox(
          height: 60.0, // Adjust the height value as per your requirements
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: makeListTile(lesson.subjectName, lesson.variable),
          ),
        ),
      );

  Future<void> _fetchBatterySet() async {
    final String dataURL = 'https://geninfo1.000webhostapp.com/GetBattSets.php';
    try {
      final response = await http.get(Uri.parse(dataURL));
      if (response.statusCode == 200) {
        setState(() {
          _dataLoaded = true;
          _dataList = json.decode(response.body);
          List<dynamic> matchedStations = _dataList
              .where((station) =>
          (station['SetID'] == widget.setID1) ||
              (station['SetID'] == widget.setID2))
              .toList();

          if (matchedStations.isNotEmpty) {
            _matchedStation1 = matchedStations[0];
            _matchedStation2 = matchedStations[1];
            _matchFound = true;
            print(_matchedStation1);
            print(_matchedStation2);
          } else {
            _matchFound = false;
          }
        });
      } else {
        setState(() {
          _dataLoaded = false;
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        _dataLoaded = false;
      });
      print(e.toString());
    }
    Timer(Duration(seconds: 3), () {
      if (!_matchFound) {
        setState(() {
          _dataLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Battery Set"),
        backgroundColor: Colors.blue,
      ),
      body: _dataLoaded
          ? SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            "Battery Set 1",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 17),
          ),
        ),
        makeCard(Lesson(
            subjectName: "Set ID",
            variable: _matchedStation1["SetID"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: " System ID",
            variable: _matchedStation1["SystemID"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Tray Count",
            variable: _matchedStation1["trayCount"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Battery Voltage",
            variable: _matchedStation1["batVolt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Battery Capacity",
            variable: _matchedStation1["batCap"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Number of Battery",
            variable: _matchedStation1["batCount"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Brand",
            variable: _matchedStation1["Brand"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Model",
            variable: _matchedStation1["model"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "conType",
            variable: _matchedStation1["conType"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Trays Set",
            variable: _matchedStation1["traysSet"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Capacity",
            variable: _matchedStation1["set_cap"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Voltage",
            variable: _matchedStation1["set_volt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Install Date",
            variable: _matchedStation1["installDt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Warranty Commencement Date",
            variable: _matchedStation1["warrantSt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Warranty Expiration Date",
            variable: _matchedStation1["warrantEd"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Last Update",
            variable: _matchedStation1["last_updated"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Uploader",
            variable: _matchedStation1["uploader"] ?? 'N/A')),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            "Battery Set 2",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 17),
          ),
        ),
        makeCard(Lesson(
            subjectName: "Set ID",
            variable: _matchedStation2["SetID"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: " System ID",
            variable: _matchedStation2["SystemID"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Tray Count",
            variable: _matchedStation2["trayCount"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Battery Voltage",
            variable: _matchedStation2["batVolt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Battery Capacity",
            variable: _matchedStation2["batCap"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Number of Battery",
            variable: _matchedStation2["batCount"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Brand",
            variable: _matchedStation2["Brand"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Model",
            variable: _matchedStation2["model"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "conType",
            variable: _matchedStation2["conType"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Trays Set",
            variable: _matchedStation2["traysSet"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Capacity",
            variable: _matchedStation2["set_cap"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Voltage",
            variable: _matchedStation2["set_volt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Install Date",
            variable: _matchedStation2["installDt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Warranty Commencement Date",
            variable: _matchedStation2["warrantSt"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Warranty Expiration Date",
            variable: _matchedStation2["warrantEd"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Last Update",
            variable: _matchedStation2["last_updated"] ?? 'N/A')),
        makeCard(Lesson(
            subjectName: "Uploader",
            variable: _matchedStation2["uploader"] ?? 'N/A')),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SizedBox(width: 100,),
            Container(
              width: 100, // Set your preferred width here
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewBatteryUnit(
                            SystemID: _matchedStation1["SystemID"],
                          ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                  // Other button style properties can be added here
                ),
                child: Center(
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(width: 30,),
            Container(
              width: 100, // Set your preferred width here
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage()
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                  // Other button style properties can be added here
                ),
                child: Center(
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    )
        : Center(
    child: CircularProgressIndicator(),
    )
    );
  }
}
