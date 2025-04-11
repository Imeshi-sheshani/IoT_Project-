import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slt_power_prox_new/View/CombinedSetPage.dart';
import 'package:slt_power_prox_new/View/Set1Page.dart';
import 'package:slt_power_prox_new/View/Set3Page.dart';
import 'package:slt_power_prox_new/View/ViewBattery.dart';
import 'package:slt_power_prox_new/View/ViewSPDUnit.dart';
import 'package:http/http.dart' as http;

class ViewBatteryUnit extends StatefulWidget {
  final String SystemID;

  ViewBatteryUnit({super.key, required this.SystemID});

  @override
  ViewBatteryUnitState createState() => ViewBatteryUnitState();
}

class ViewBatteryUnitState extends State<ViewBatteryUnit> {
  bool _dataLoaded = false;
  List<dynamic> _dataList = [];
  bool _matchFound = false;
  Map<String, dynamic> _matchedStation = {};

  void initState() {
    super.initState();
    _fetchBatteryRack();
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
          height: 60.0, //
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: makeListTile(lesson.subjectName, lesson.variable),
          ),
        ),
      );

  Future<void> _fetchBatteryRack() async {
    final String dataURL = 'https://geninfo1.000webhostapp.com/GetBatSys.php';
    try {
      final response = await http.get(Uri.parse(dataURL));
      if (response.statusCode == 200) {
        setState(() {
          _dataLoaded = true;
          _dataList = json.decode(response.body);
          _matchedStation = _dataList.firstWhere(
            (station) => station['SystemID'] == widget.SystemID,
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
        title: Text("Battery Unit Details"),
        backgroundColor: Colors.blue,
      ),
      body: _dataLoaded
          ? SingleChildScrollView(
              child: Column(
                children: [
                  makeCard(Lesson(
                      subjectName: 'Battery ID',
                      variable: _matchedStation['SystemID'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Region',
                      variable: _matchedStation['Region'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Site',
                      variable: _matchedStation['Site'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'System Type',
                      variable: _matchedStation['sysType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Battery Type',
                      variable: _matchedStation['batType'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Location',
                      variable: _matchedStation['Location'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Set Number',
                      variable: _matchedStation['SetNo'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Notes',
                      variable: _matchedStation['Notes'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Last Update',
                      variable: _matchedStation['last_updated'] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: 'Uploader',
                      variable: _matchedStation['uploader'] ?? 'N/A')),
                  ElevatedButton(
                    onPressed: () {
                      String buttonText = '';
                      Function()? onPressed;

                      if (_matchedStation["SetNo"] == "1") {
                        buttonText = 'for set No 1';
                        onPressed = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => //Set1Page(setID: '111')
                                    CombinedSetPage(
                                        setId1: '111',
                                        setId2: null,
                                        setId3: null)),
                          );
                        };
                      } else if (_matchedStation["SetNo"] == "2") {
                        buttonText = 'for set No 2';
                        onPressed = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:
                                    (context) => //Set2Page(setID1: "118", setID2: "119",)
                                        CombinedSetPage(
                                            setId1: "118",
                                            setId2: "119",
                                            setId3: null)),
                          );
                        };
                      } else if (_matchedStation["SetNo"] == "3") {
                        buttonText = 'for set No 3';
                        onPressed = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:
                                    (context) => //Set3Page(setId1: '124', setId2: '125', setId3: '126')
                                        CombinedSetPage(
                                            setId1: "124",
                                            setId2: "125",
                                            setId3: "126")),
                          );
                        };
                      }

                      if (onPressed != null) {
                        onPressed();
                      } else {}
                    },
                    child: Text(
                      _matchedStation["SetNo"] == "1"
                          ? 'View Battery Set'
                          : _matchedStation["SetNo"] == "2"
                              ? 'View Battery Set'
                              : _matchedStation["SetNo"] == "3"
                                  ? 'View Battery Set'
                                  : 'No valid SetNo',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                    ),
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

//V1
// import 'package:flutter/material.dart';
//
// class ViewBatteryUnit extends StatelessWidget {
//   final dynamic batteryUnit;
//
//   ViewBatteryUnit({required this.batteryUnit});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Battery Unit Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Site: ${batteryUnit['Site']}'),
//             Text('Location: ${batteryUnit['Location']}'),
//             // Display other battery unit details as needed
//           ],
//         ),
//       ),
//     );
//   }
// }
