import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewRectifierUnit extends StatefulWidget {
  String station;

  ViewRectifierUnitState createState() => ViewRectifierUnitState();

  ViewRectifierUnit({super.key, required this.station});
}

class ViewRectifierUnitState extends State<ViewRectifierUnit> {
  bool _dataLoaded = false;
  bool _isLoading = true;
  List<dynamic> _dataList = [];
  bool _matchFound = false;
  Map<String, dynamic> _matchedStation = {};

  void initState() {
    super.initState();
    _fetchRectifier();
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

  Future<void> _fetchRectifier() async {
    final String dataURL = 'https://geninfo1.000webhostapp.com/GetRecSys.php';
    try {
      final response = await http.get(Uri.parse(dataURL));
      if (response.statusCode == 200) {
        setState(() {
          _dataLoaded = true;
          _dataList = json.decode(response.body);
          _matchedStation = _dataList.firstWhere(
                (station) => station['Station'] == widget.station,
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
        title: Text("Rectifier details"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _buildDataWidget(),
      ),
    );
  }

  Widget _buildDataWidget() {
    if (!_dataLoaded) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            makeCard(Lesson(
                subjectName: 'Rectifier ID',
                variable: _matchedStation['RecID'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Region',
                variable: _matchedStation['Region'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'RTOM',
                variable: _matchedStation['RTOM'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Station',
                variable: _matchedStation['Station'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Brand',
                variable: _matchedStation['Brand'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Model',
                variable: _matchedStation['Model'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Frame Capacity Type',
                variable: _matchedStation['FrameCapType'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Frame Capacity',
                variable: _matchedStation['FrameCap'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Type',
                variable: _matchedStation['Type'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Serial Number',
                variable: _matchedStation['Serial'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Installed Date',
                variable: _matchedStation['InstalledDate'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Power Module Model',
                variable: _matchedStation['PWModModel'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Ampere Rating',
                variable: _matchedStation['AmpRating'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Power Module Slots',
                variable: _matchedStation['PWModsUsed'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Power Modules Available',
                variable: _matchedStation['PWModsAvai'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Control Module Model',
                variable: _matchedStation['CtrModModel'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Control Modules Slots',
                variable: _matchedStation["CtrModsUsed"])),
            makeCard(Lesson(
                subjectName: 'Control Modules Available',
                variable: _matchedStation['CtrModsAvail'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Last Updated',
                variable: _matchedStation['LastUpdated'] ?? 'N/A')),
            makeCard(Lesson(
                subjectName: 'Updated By',
                variable: _matchedStation['Updated_By'] ?? 'N/A')),

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
