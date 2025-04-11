import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../MyHomePage.dart';
import 'ViewBattery.dart';

class CombinedSetPage extends StatefulWidget {
  final String? setId1;
  final String? setId2;
  final String? setId3;

  CombinedSetPage({
    Key? key,
    required this.setId1,
    required this.setId2,
    required this.setId3,
  }) : super(key: key);

  @override
  _CombinedSetPageState createState() => _CombinedSetPageState();
}

class _CombinedSetPageState extends State<CombinedSetPage> {
  bool _dataLoaded = false;
  List<dynamic> _dataList = [];
  bool _matchFound = false;
  List<Map<String, dynamic>> _matchedStations = [];

  @override
  void initState() {
    super.initState();
    _fetchBatterySets();
  }

  Future<void> _fetchBatterySets() async {
    final String dataURL = 'https://geninfo1.000webhostapp.com/GetBattSets.php';
    try {
      final response = await http.get(Uri.parse(dataURL));
      if (response.statusCode == 200) {
        setState(() {
          _dataLoaded = true;
          _dataList = json.decode(response.body);
          List<Map<String, dynamic>> filteredStations = _dataList
              .where((station) => (station['SetID'] == widget.setId1 ||
              station['SetID'] == widget.setId2 ||
              station['SetID'] == widget.setId3))
              .cast<Map<String, dynamic>>()
              .toList();

          _matchedStations = filteredStations;
          _matchFound = _matchedStations.isNotEmpty;
          //print(_matchedStations);

          if (_matchedStations.isNotEmpty) {
            if (_matchedStations.length == 1) {
              Map<String, dynamic> station1 = _matchedStations[0];
              print('Battery Set 1: $station1');
            }
            if (_matchedStations.length == 2) {
              Map<String, dynamic> station1 = _matchedStations[0];
              Map<String, dynamic> station2 = _matchedStations[1];
              print('Battery Set 1: $station1');
              print('Battery Set 2: $station2');
            }
            if (_matchedStations.length == 3) {
              Map<String, dynamic> station1 = _matchedStations[0];
              Map<String, dynamic> station2 = _matchedStations[1];
              Map<String, dynamic> station3 = _matchedStations[2];
              print('Battery Set 1: $station1');
              print('Battery Set 2: $station2');
              print('Battery Set 3: $station3');
            }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Battery Sets"),
        backgroundColor: Colors.blue,
      ),
      body: _dataLoaded
          ? SingleChildScrollView(
        child: Column(
          children: [
            if (_matchedStations.length == 1)
              Column(
                children: [
                  SizedBox(height: 10,),
                  Text(
                    "Battery Set 1",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(height: 15,),
                  makeCard(Lesson(
                      subjectName: "Set ID",
                      variable: _matchedStations[0]["SetID"])),
                  makeCard(Lesson(
                      subjectName: "System ID",
                      variable:
                      _matchedStations[0]["SystemID"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Tray Count',
                      variable:
                      _matchedStations[0]['trayCount'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Battery Voltage",
                      variable: _matchedStations[0]["batVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Battery Capacity',
                      variable: _matchedStations[0]['batCap'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Number of batteries in the rack",
                      variable:
                      _matchedStations[0]["batCount"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Brand',
                      variable: _matchedStations[0]['Brand'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Model",
                      variable: _matchedStations[0]["model"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'ConType', // change the subject name
                      variable: _matchedStations[0]['conType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Trays Set",
                      variable:
                      _matchedStations[0]["traysSet"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Capacity",
                      variable: _matchedStations[0]["set_cap"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Voltage",
                      variable:
                      _matchedStations[0]["set_volt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Installed Date",
                      variable:
                      _matchedStations[0]["installDt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Commencement Date",
                      variable:
                      _matchedStations[0]["warrantSt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Expiration Date",
                      variable:
                      _matchedStations[0]["warrantEd"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Last Update",
                      variable:
                      _matchedStations[0]["last_updated"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Uploader",
                      variable:
                      _matchedStations[0]["uploader"] ?? 'N/A')),
                  SizedBox(
                    height: 15,
                  ),
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
                                  SystemID: _matchedStations[0]
                                  ["SystemID"],
                                ),
                              ));
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ));
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                      ),
                    ],
                  ),
                ],
              ),
            if (_matchedStations.length == 2)
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Battery Set 1",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  makeCard(Lesson(
                      subjectName: "Set ID",
                      variable: _matchedStations[0]["SetID"])),
                  makeCard(Lesson(
                      subjectName: "System ID",
                      variable:
                      _matchedStations[0]["SystemID"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Tray Count',
                      variable:
                      _matchedStations[0]['trayCount'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Battery Voltage",
                      variable: _matchedStations[0]["batVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Battery Capacity',
                      variable: _matchedStations[0]['batCap'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Number of batteries in the rack",
                      variable:
                      _matchedStations[0]["batCount"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Brand',
                      variable: _matchedStations[0]['Brand'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Model",
                      variable: _matchedStations[0]["model"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'ConType', // change the subject name
                      variable: _matchedStations[0]['conType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Trays Set",
                      variable:
                      _matchedStations[0]["traysSet"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Capacity",
                      variable: _matchedStations[0]["set_cap"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Voltage",
                      variable:
                      _matchedStations[0]["set_volt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Installed Date",
                      variable:
                      _matchedStations[0]["installDt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Commencement Date",
                      variable:
                      _matchedStations[0]["warrantSt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Expiration Date",
                      variable:
                      _matchedStations[0]["warrantEd"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Last Update",
                      variable:
                      _matchedStations[0]["last_updated"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Uploader",
                      variable:
                      _matchedStations[0]["uploader"] ?? 'N/A')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Battery Set 2",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  makeCard(Lesson(
                      subjectName: "Set ID",
                      variable: _matchedStations[1]["SetID"])),
                  makeCard(Lesson(
                      subjectName: "System ID",
                      variable:
                      _matchedStations[1]["SystemID"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Tray Count',
                      variable:
                      _matchedStations[1]['trayCount'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Battery Voltage",
                      variable: _matchedStations[1]["batVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Battery Capacity',
                      variable: _matchedStations[1]['batCap'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Number of batteries in the rack",
                      variable:
                      _matchedStations[1]["batCount"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Brand',
                      variable: _matchedStations[1]['Brand'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Model",
                      variable: _matchedStations[1]["model"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'ConType', // change the subject name
                      variable: _matchedStations[1]['conType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Trays Set",
                      variable:
                      _matchedStations[1]["traysSet"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Capacity",
                      variable: _matchedStations[1]["set_cap"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Voltage",
                      variable:
                      _matchedStations[1]["set_volt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Installed Date",
                      variable:
                      _matchedStations[1]["installDt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Commencement Date",
                      variable:
                      _matchedStations[1]["warrantSt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Expiration Date",
                      variable:
                      _matchedStations[1]["warrantEd"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Last Update",
                      variable:
                      _matchedStations[1]["last_updated"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Uploader",
                      variable:
                      _matchedStations[1]["uploader"] ?? 'N/A')),
                  SizedBox(
                    height: 15,
                  ),
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
                                  SystemID: _matchedStations[1]
                                  ["SystemID"],
                                ),
                              ));
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ));
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                      ),
                    ],
                  ),
                ],
              ),
            if (_matchedStations.length == 3)
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Battery Set 1",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  makeCard(Lesson(
                      subjectName: "Set ID",
                      variable: _matchedStations[0]["SetID"])),
                  makeCard(Lesson(
                      subjectName: "System ID",
                      variable:
                      _matchedStations[0]["SystemID"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Tray Count',
                      variable:
                      _matchedStations[0]['trayCount'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Battery Voltage",
                      variable: _matchedStations[0]["batVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Battery Capacity',
                      variable: _matchedStations[0]['batCap'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Number of batteries in the rack",
                      variable:
                      _matchedStations[0]["batCount"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Brand',
                      variable: _matchedStations[0]['Brand'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Model",
                      variable: _matchedStations[0]["model"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'ConType', // change the subject name
                      variable: _matchedStations[0]['conType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Trays Set",
                      variable:
                      _matchedStations[0]["traysSet"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Capacity",
                      variable: _matchedStations[0]["set_cap"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Voltage",
                      variable:
                      _matchedStations[0]["set_volt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Installed Date",
                      variable:
                      _matchedStations[0]["installDt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Commencement Date",
                      variable:
                      _matchedStations[0]["warrantSt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Expiration Date",
                      variable:
                      _matchedStations[0]["warrantEd"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Last Update",
                      variable:
                      _matchedStations[0]["last_updated"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Uploader",
                      variable:
                      _matchedStations[0]["uploader"] ?? 'N/A')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Battery Set 2",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  makeCard(Lesson(
                      subjectName: "Set ID",
                      variable: _matchedStations[1]["SetID"])),
                  makeCard(Lesson(
                      subjectName: "System ID",
                      variable:
                      _matchedStations[1]["SystemID"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Tray Count',
                      variable:
                      _matchedStations[1]['trayCount'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Battery Voltage",
                      variable: _matchedStations[1]["batVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Battery Capacity',
                      variable: _matchedStations[1]['batCap'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Number of batteries in the rack",
                      variable:
                      _matchedStations[1]["batCount"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Brand',
                      variable: _matchedStations[1]['Brand'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Model",
                      variable: _matchedStations[1]["model"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'ConType', // change the subject name
                      variable: _matchedStations[1]['conType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Trays Set",
                      variable:
                      _matchedStations[1]["traysSet"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Capacity",
                      variable: _matchedStations[1]["set_cap"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Voltage",
                      variable:
                      _matchedStations[1]["set_volt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Installed Date",
                      variable:
                      _matchedStations[1]["installDt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Commencement Date",
                      variable:
                      _matchedStations[1]["warrantSt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Expiration Date",
                      variable:
                      _matchedStations[1]["warrantEd"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Last Update",
                      variable:
                      _matchedStations[1]["last_updated"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Uploader",
                      variable:
                      _matchedStations[1]["uploader"] ?? 'N/A')),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Battery Set 3",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  makeCard(Lesson(
                      subjectName: "Set ID",
                      variable: _matchedStations[2]["SetID"])),
                  makeCard(Lesson(
                      subjectName: "System ID",
                      variable:
                      _matchedStations[2]["SystemID"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Tray Count',
                      variable:
                      _matchedStations[2]['trayCount'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Battery Voltage",
                      variable: _matchedStations[2]["batVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Battery Capacity',
                      variable: _matchedStations[2]['batCap'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Number of batteries in the rack",
                      variable:
                      _matchedStations[2]["batCount"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Brand',
                      variable: _matchedStations[2]['Brand'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Model",
                      variable: _matchedStations[2]["model"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'ConType', // change the subject name
                      variable: _matchedStations[2]['conType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Trays Set",
                      variable:
                      _matchedStations[2]["traysSet"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Capacity",
                      variable: _matchedStations[2]["set_cap"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Set Voltage",
                      variable:
                      _matchedStations[2]["set_volt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Installed Date",
                      variable:
                      _matchedStations[2]["installDt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Commencement Date",
                      variable:
                      _matchedStations[2]["warrantSt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Warranty Expiration Date",
                      variable:
                      _matchedStations[2]["warrantEd"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Last Update",
                      variable:
                      _matchedStations[2]["last_updated"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Uploader",
                      variable:
                      _matchedStations[2]["uploader"] ?? 'N/A')),
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
                                  SystemID: _matchedStations[1]
                                  ["SystemID"],
                                ),
                              ));
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ));
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Lesson {
  final String subjectName;
  final String variable;

  Lesson({required this.subjectName, required this.variable});
}
