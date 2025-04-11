import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

int _scanType = 0;

class InfoPage extends StatefulWidget {
  final String qrText;

  InfoPage({super.key, required this.qrText});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _scanType = 0;
  bool _dataLoaded = false;
  List<dynamic> _dataList = [];
  Map<String, dynamic> _matchedStation = {};
  bool _matchFound = false;

  @override
  void initState() {
    super.initState();

    if (widget.qrText.startsWith('B:')) {
      _scanType = 1;
      print('Fetching Battery');
      //_fetchBattery();
    }
    if (widget.qrText.startsWith("S:") || widget.qrText == '2') {
      _scanType = 2;
      print("Fetching SPD");
      //_fetchUPS();
    }
    if (widget.qrText.startsWith("U:")) {
      _scanType = 3;
      //_fetchUPS();
      print("Fetching UPS");
    } else if (widget.qrText.startsWith("R:")) {
      _scanType = 4;
      //_fetchRectifier();
      print("Fetching Rectifier");
    } else {
      _scanType = 0; // zero for Gen
      _fetchGenerator();
      print("Fetching Generators");
    }
  }

  Future<void> _fetchGenerator() async {
    final String dataUrl =
        'https://geninfo1.000webhostapp.com/GetSPDdetails.php';
    try {
      final response = await http.get(Uri.parse(dataUrl));
      if (response.statusCode == 200) {
        setState(() {
          _dataList = json.decode(response.body);
          _dataLoaded = true;
          _matchedStation = _dataList.firstWhere(
              (station) => station['Station'] == widget.qrText,
              orElse: () => {});
          _matchFound = _matchedStation.isNotEmpty;
          print(_matchedStation);
        });
      } else {
        setState(() {
          _dataLoaded = false;
        });
        throw Exception("Failed to load data");
      }
    } catch (error) {
      setState(() {
        _dataLoaded = false;
      });
      print(error.toString());
    }

    Timer(Duration(seconds: 3), () {
      if (!_matchFound) {
        setState(() {
          _dataLoaded = true;
        });
      }
    });
  }

  Future<void> _fetchSPD() async {
    final String dataurl =
        "https://geninfo1.000webhostapp.com/GetSPDdetails.php";
    try {
      final response = await http.get(Uri.parse(dataurl));
      if (response.statusCode == 200) {
        _dataList = json.decode(response.body);
      }
    } catch (err) {
      print(err.toString());
    }
  }

  ListTile MakeListTile(String subjectName, String? variable) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          //padding: EdgeInsets.only(left: 12.0),
          decoration: new BoxDecoration(
            border: new Border(
              left: new BorderSide(width: 1.0, color: Colors.white),
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

  Card MakeCard(Lesson lesson) => Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: SizedBox(
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: MakeListTile(lesson.subjectName, lesson.variable),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Lesson {
  Lesson({required this.subjectName, required this.variable});

  final String subjectName;
  final String variable;
}
