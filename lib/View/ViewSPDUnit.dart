import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewSPDUnit extends StatefulWidget{
  ViewSPDUnitState createState() => ViewSPDUnitState();
  String station;
  ViewSPDUnit({super.key, required this.station});
}

class ViewSPDUnitState extends State<ViewSPDUnit>{

  bool _dataLoaded = false;
  bool _isLoading = true;
  List<dynamic> _dataList = [];
  bool _matchFound = false;
  Map<String, dynamic> _matchedStation = {};

  void initState(){
    super.initState();
    _fetchSPD();
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

  Future<void> _fetchSPD() async {
    final String dataURL =
        'https://geninfo1.000webhostapp.com/GetSPDdetails.php';
    try {
      final response = await http.get(Uri.parse(dataURL));
      if (response.statusCode == 200) {
        setState(() {
          _dataLoaded = true;
          _dataList = json.decode(response.body);
          _matchedStation = _dataList.firstWhere(
                (station) => station['station'] == widget.station,
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
          title: Text("SPD Unit Details"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildDataWidget(),
        ),
    );
  }

  Widget? _buildDataWidget(){
    if(!_dataLoaded){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else{
      return SingleChildScrollView(
        child: Column(
          children: [
            makeCard(Lesson(
                subjectName: 'SPDid',
                variable: _matchedStation['SPDid'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'province',
                variable: _matchedStation['province'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Rtom_name',
                variable: _matchedStation['Rtom_name'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Station',
                variable: _matchedStation['station'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'SPD Location',
                variable: _matchedStation['SPDLoc'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'DCFlag',
                variable: _matchedStation['DCFlag'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: "Poles", variable: _matchedStation["poles"])),
            makeCard(Lesson(
                subjectName: 'SPD Type',
                variable: _matchedStation['SPDType'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'SPD Manufacture',
                variable: _matchedStation['SPD_Manu'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'SPD Model',
                variable: _matchedStation['model_SPD'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Status',
                variable: _matchedStation['Status'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'SPD Type',
                variable: _matchedStation['SPDType'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'installed Date',
                variable: _matchedStation['installDt'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Warranty Date',
                variable: _matchedStation['warrentyDt'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Notes',
                variable: _matchedStation['Notes'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Response Time',
                variable: _matchedStation['responseTime'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Submitter',
                variable: _matchedStation['Submitter'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Last Updated',
                variable: _matchedStation['LastUpdated'] ?? 'N/A')),

            //Match line 358 to line 369 correctly whether they are common, AC or DC

            // makeCard(Lesson(
            //     subjectName: 'PercentageR',
            //     variable: _matchedStation['PercentageR'] ?? 'N/A')),
            // makeCard(Lesson(
            //     subjectName: 'PercentageY',
            //     variable: _matchedStation['PercentageY'] ?? 'N/A')),
            // makeCard(Lesson(
            //     subjectName: 'PercentageB',
            //     variable: _matchedStation['PercentageB'] ?? 'N/A')),
            // makeCard(Lesson(
            //     subjectName: "MCB Rating",
            //     variable: _matchedStation["mcbRating"] ?? 'N/A')),
            if (_matchedStation["DCFlag"] == "0")
              Column(
                children: [
                  makeCard(Lesson(
                      subjectName: "modular",
                      variable: _matchedStation["modular"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "phase",
                      variable: _matchedStation["phase"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName:
                      "Max continuous operating voltage live-type",
                      variable: _matchedStation["UcLiveMode"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName:
                      "Maximum continuous operating voltage live - reading",
                      variable: _matchedStation["UcLiveVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Max continuous operating voltage-neutral",
                      variable: _matchedStation["UcNeutralVolt"] ?? 'N/A')),
                  // Type the subject name correctly (UpLiveVolt and UpNeutralVolt)
                  makeCard(Lesson(
                      subjectName: "UpLiveVolt",
                      variable: _matchedStation["UpLiveVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "UpNeutralVolt",
                      variable: _matchedStation["UpNeutralVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "discharge Type",
                      variable: _matchedStation["dischargeType"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Line 8 to 20 Nominal Discharge",
                      variable: _matchedStation["L8to20NomD"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Neutral 8 to 20 Nominal Discharge",
                      variable: _matchedStation["N8to20NomD"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "line 10 to 350 impulse discharge",
                      variable: _matchedStation["L10to350ImpD"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Neutral 10 to 350 impulse discharge",
                      variable: _matchedStation["N10to350ImpD"] ?? 'N/A')),
                ],
              )
            else
              Column(
                children: [

                  makeCard(Lesson(
                      subjectName: "Voltage Protection Level DC",
                      variable: _matchedStation["UpDCVolt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "Nominal Discharge Current 8/20",
                      variable: _matchedStation["Nom_Dis8_20"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "impulse current 10/350",
                      variable: _matchedStation["Nom_Dis10_350"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "nominal voltage un",
                      variable: _matchedStation["nom_volt"] ?? 'N/A')),
                  makeCard(Lesson(
                      subjectName: "maximum continuous operating voltage dc",
                      variable: _matchedStation["UcDCVolt"] ?? 'N/A'))
                ],
              )
          ],
        ),
      );
    }
  }
}



class Lesson {
  final String subjectName;
  final String variable;

  Lesson({required this.subjectName, required this.variable});
}
