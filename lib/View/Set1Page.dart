import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slt_power_prox_new/MyHomePage.dart';
import 'package:slt_power_prox_new/View/ViewBattery.dart';

class Set1Page extends StatefulWidget {
  final String setID;

  const Set1Page({super.key, required this.setID});

  Set1PageState createState() => Set1PageState();
}

class Set1PageState extends State<Set1Page> {
  bool _dataLoaded = false;
  List<dynamic> _dataList = [];
  bool _matchFound = false;
  Map<String, dynamic> _matchedStation = {};

  void initState() {
    super.initState();
    _fetchBatterySet();
  }

  ListTile makeListTile(String subjectName, String? variable) => ListTile(
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

  Card makeCard(Lesson lesson) => Card(
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
          _matchedStation = _dataList.firstWhere(
            (station) => station['SetID'] == widget.setID,
            orElse: () => {},
          );
          _matchFound = _matchedStation.isNotEmpty;
          print(_matchedStation);
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

    // Display CircularProgressIndicator for 3 seconds even if no data was found
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
                    makeCard(Lesson(
                        subjectName: 'Set ID',
                        variable: _matchedStation['SetID'] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "System ID",
                        variable: _matchedStation["SystemID"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: 'Tray Count',
                        variable: _matchedStation['trayCount'] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Battery Voltage",
                        variable: _matchedStation["batVolt"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: 'Battery Capacity',
                        variable: _matchedStation['batCap'] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Number of batteries in the rack",
                        variable: _matchedStation["batCount"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: 'Brand',
                        variable: _matchedStation['Brand'] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Model",
                        variable: _matchedStation["model"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: 'ConType', // change the subject name
                        variable: _matchedStation['conType'] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Trays Set",
                        variable: _matchedStation["traysSet"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Set Capacity",
                        variable: _matchedStation["set_cap"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Set Voltage",
                        variable: _matchedStation["set_volt"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Installed Date",
                        variable: _matchedStation["installDt"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Warranty Commencement Date",
                        variable: _matchedStation["warrantSt"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Warranty Expiration Date",
                        variable: _matchedStation["warrantEd"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Last Update",
                        variable: _matchedStation["last_updated"] ?? 'N/A')),
                    makeCard(Lesson(
                        subjectName: "Uploader",
                        variable: _matchedStation["uploader"] ?? 'N/A')),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewBatteryUnit(
                                        SystemID:
                                            _matchedStation["SystemID"])));
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.black),
                          ),
                          style:
                              ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.black),
                          ),
                          style:
                              ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class Lesson {
  final String subjectName;
  final String variable;

  Lesson({required this.subjectName, required this.variable});
}
