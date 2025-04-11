/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DailyUsageScreen extends StatefulWidget {
  final String locationId;

  DailyUsageScreen({required this.locationId});

  @override
  _DailyUsageScreenState createState() => _DailyUsageScreenState();
}

class _DailyUsageScreenState extends State<DailyUsageScreen> {
  DateTime? startDate;
  DateTime? endDate;
  Map<String, double> kwhData = {
    'IT kwh': 0.0,
    'AC kwh': 0.0,
    'Light kwh': 0.0,
  };
  bool isLoading = false;

  Future<void> fetchAndCalculateData() async {
    if (startDate == null || endDate == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://powerprox.sltidc.lk/GET_DailyEnergyUsage.php'));

    if (response.statusCode == 200) {
      final List<dynamic> usageData = json.decode(response.body);
      Map<String, double> startKwh = {
        'IT kwh': 0.0,
        'AC kwh': 0.0,
        'Light kwh': 0.0,
      };
      Map<String, double> endKwh = {
        'IT kwh': 0.0,
        'AC kwh': 0.0,
        'Light kwh': 0.0,
      };

      for (var usage in usageData) {
        if (usage['LocationID'].toString() == widget.locationId) {
          DateTime date = DateTime.parse(usage['Date']);
          double kwh = double.tryParse(usage['kWh'].toString()) ?? 0.0;
          int loadTypeID = int.tryParse(usage['LoadTypeID'].toString()) ?? 0;

          if (date == startDate) {
            if (loadTypeID == 1) {
              startKwh['IT kwh'] = (startKwh['IT kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 2) {
              startKwh['AC kwh'] = (startKwh['AC kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 3) {
              startKwh['Light kwh'] = (startKwh['Light kwh'] ?? 0.0) + kwh;
            }
          } else if (date == endDate) {
            if (loadTypeID == 1) {
              endKwh['IT kwh'] = (endKwh['IT kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 2) {
              endKwh['AC kwh'] = (endKwh['AC kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 3) {
              endKwh['Light kwh'] = (endKwh['Light kwh'] ?? 0.0) + kwh;
            }
          }
        }
      }

      setState(() {
        kwhData['IT kwh'] = (endKwh['IT kwh'] ?? 0.0) - (startKwh['IT kwh'] ?? 0.0);
        kwhData['AC kwh'] = (endKwh['AC kwh'] ?? 0.0) - (startKwh['AC kwh'] ?? 0.0);
        kwhData['Light kwh'] = (endKwh['Light kwh'] ?? 0.0) - (startKwh['Light kwh'] ?? 0.0);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != startDate) {
                        setState(() {
                          startDate = picked;
                        });
                      }
                    },
                    child: Text(startDate == null
                        ? 'Select Start Date'
                        : startDate.toString().split(' ')[0]),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != endDate) {
                        setState(() {
                          endDate = picked;
                        });
                      }
                    },
                    child: Text(endDate == null
                        ? 'Select End Date'
                        : endDate.toString().split(' ')[0]),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: fetchAndCalculateData,
                )
              ],
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('IT kWh')),
                DataColumn(label: Text('AC kWh')),
                DataColumn(label: Text('Light kWh')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text(kwhData['IT kwh'].toString())),
                    DataCell(Text(kwhData['AC kwh'].toString())),
                    DataCell(Text(kwhData['Light kwh'].toString())),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DailyUsageScreen extends StatefulWidget {
  final String locationId;

  DailyUsageScreen({required this.locationId});

  @override
  _DailyUsageScreenState createState() => _DailyUsageScreenState();
}

class _DailyUsageScreenState extends State<DailyUsageScreen> {
  DateTime? startDate;
  DateTime? endDate;
  Map<String, double> kwhData = {
    'IT kwh': 0.0,
    'AC kwh': 0.0,
    'Light kwh': 0.0,
  };
  bool isLoading = false;

  Future<void> fetchAndCalculateData() async {
    if (startDate == null || endDate == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse('https://powerprox.sltidc.lk/GET_DailyEnergyUsage.php'));

    if (response.statusCode == 200) {
      final List<dynamic> usageData = json.decode(response.body);
      Map<String, double> startKwh = {
        'IT kwh': 0.0,
        'AC kwh': 0.0,
        'Light kwh': 0.0,
      };
      Map<String, double> endKwh = {
        'IT kwh': 0.0,
        'AC kwh': 0.0,
        'Light kwh': 0.0,
      };

      for (var usage in usageData) {
        if (usage['LocationID'].toString() == widget.locationId) {
          DateTime date = DateTime.parse(usage['Date']);
          double kwh = double.tryParse(usage['kWh'].toString()) ?? 0.0;
          int loadTypeID = int.tryParse(usage['LoadTypeID'].toString()) ?? 0;

          if (date == startDate) {
            if (loadTypeID == 1) {
              startKwh['IT kwh'] = (startKwh['IT kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 2) {
              startKwh['AC kwh'] = (startKwh['AC kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 3) {
              startKwh['Light kwh'] = (startKwh['Light kwh'] ?? 0.0) + kwh;
            }
          } else if (date == endDate) {
            if (loadTypeID == 1) {
              endKwh['IT kwh'] = (endKwh['IT kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 2) {
              endKwh['AC kwh'] = (endKwh['AC kwh'] ?? 0.0) + kwh;
            } else if (loadTypeID == 3) {
              endKwh['Light kwh'] = (endKwh['Light kwh'] ?? 0.0) + kwh;
            }
          }
        }
      }

      setState(() {
        kwhData['IT kwh'] =
            (endKwh['IT kwh'] ?? 0.0) - (startKwh['IT kwh'] ?? 0.0);
        kwhData['AC kwh'] =
            (endKwh['AC kwh'] ?? 0.0) - (startKwh['AC kwh'] ?? 0.0);
        kwhData['Light kwh'] =
            (endKwh['Light kwh'] ?? 0.0) - (startKwh['Light kwh'] ?? 0.0);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != startDate) {
                        setState(() {
                          startDate = picked;
                        });
                      }
                    },
                    child: Text(startDate == null
                        ? 'Select Start Date'
                        : startDate.toString().split(' ')[0]),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != endDate) {
                        setState(() {
                          endDate = picked;
                        });
                      }
                    },
                    child: Text(endDate == null
                        ? 'Select End Date'
                        : endDate.toString().split(' ')[0]),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: fetchAndCalculateData,
            child: Text('Load Data'),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('IT kWh')),
                      DataColumn(label: Text('AC kWh')),
                      DataColumn(label: Text('Light kWh')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text(kwhData['IT kwh'].toString())),
                          DataCell(Text(kwhData['AC kwh'].toString())),
                          DataCell(Text(kwhData['Light kwh'].toString())),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
