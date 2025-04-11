
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonthlyUsageScreen extends StatefulWidget {
  final String locationId;

  MonthlyUsageScreen({required this.locationId});

  @override
  _MonthlyUsageScreenState createState() => _MonthlyUsageScreenState();
}

class _MonthlyUsageScreenState extends State<MonthlyUsageScreen> {
  late Future<List<Map<String, dynamic>>> combinedData;
  String selectedYear = DateTime.now().year.toString();
  List<String> years = List.generate(10, (index) => (DateTime.now().year - index).toString());

  @override
  void initState() {
    super.initState();
    combinedData = fetchCombinedData(widget.locationId, selectedYear);
  }

  Future<List<Map<String, dynamic>>> fetchCombinedData(String locationId, String year) async {
    final usageResponse = await http.get(
      Uri.parse('http://124.43.136.185/GET_MonthlyEnergyUsage.php'),
      headers: {
        'LocationID': locationId,
        'Year': year,  // Pass the selected year as a header or query parameter
      },
    );

    if (usageResponse.statusCode != 200) {
      throw Exception('Failed to load usage data');
    }

    final List<dynamic> usageData = json.decode(usageResponse.body);
    final Map<int, Map<String, double>> monthlyData = {
      for (int i = 1; i <= 12; i++) i: {
        'AC kwh': 0.0,
        'IT kwh': 0.0,
        'Light kwh': 0.0,
      }
    };

    for (var usage in usageData) {
      final String fetchedLocationID = usage['LocationID'].toString();
      final DateTime dateTime = DateTime.parse(usage['Month']);
      if (fetchedLocationID == locationId && dateTime.year.toString() == year) {
        final int month = dateTime.month;
        final int loadTypeID = int.tryParse(usage['LoadTypeID'].toString()) ?? 0;
        final double kwh = double.tryParse(usage['kWh'].toString()) ?? 0.0;

        if (monthlyData.containsKey(month)) {
          if (loadTypeID == 2) {
            monthlyData[month]!['AC kwh'] = (monthlyData[month]!['AC kwh'] ?? 0.0) + kwh;
          } else if (loadTypeID == 1) {
            monthlyData[month]!['IT kwh'] = (monthlyData[month]!['IT kwh'] ?? 0.0) + kwh;
          } else if (loadTypeID == 3) {
            monthlyData[month]!['Light kwh'] = (monthlyData[month]!['Light kwh'] ?? 0.0) + kwh;
          }
        }
      }
    }

    List<Map<String, dynamic>> sortedData = monthlyData.entries.map((entry) {
      return {
        'Month': entry.key,
        'AC kwh': entry.value['AC kwh'],
        'IT kwh': entry.value['IT kwh'],
        'Light kwh': entry.value['Light kwh'],
      };
    }).toList();

    // Sort the data by month number (key)
    sortedData.sort((a, b) => a['Month'].compareTo(b['Month']));

    return sortedData;
  }

  String monthNumberToName(int monthNumber) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return monthNames[monthNumber - 1];
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
                Text(
                  'Select Year: ',
                  style: TextStyle(

                    fontWeight: FontWeight.bold, // Optional: Make the text bold
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100], // Background color of the dropdown
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.blue, // Border color of the dropdown
                      width: 2, // Border width of the dropdown
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: selectedYear,
                    underline: SizedBox(), // Remove the default underline
                    items: years.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedYear = newValue!;
                        combinedData = fetchCombinedData(widget.locationId, selectedYear);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: combinedData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Month')),
                          DataColumn(label: Text('AC kwh')),
                          DataColumn(label: Text('IT kwh')),
                          DataColumn(label: Text('Light kwh')),
                        ],
                        rows: snapshot.data!.map((row) {
                          return DataRow(
                            cells: [
                              DataCell(Text('${monthNumberToName(row['Month'])}')),
                              DataCell(Text(row['AC kwh'].toString())),
                              DataCell(Text(row['IT kwh'].toString())),
                              DataCell(Text(row['Light kwh'].toString())),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
