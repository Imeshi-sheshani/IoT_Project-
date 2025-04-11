/*
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;
import 'package:share/share.dart';


/*
Here, the monthly usage is displayed according to the load type.
The monthly usage is in the sql db. There, the last month kWh related
to the load type is filtered and obtained.

Select  the load type on the load_id and display the last month's usage .

Sum button is clicked , display the total KWh in all type

Export button is clicked , can share the CSV file .
 */

class MonthlyUsagePage extends StatefulWidget {
  @override
  _MonthlyUsagePageState createState() => _MonthlyUsagePageState();
}

class _MonthlyUsagePageState extends State<MonthlyUsagePage> {
  List<MonthlyUsageData> monthlyUsage = [];
  bool loading = false;
  String errorMessage = '';
  double totalITLoadKWh = 0;
  double totalACLoadKWh = 0;
  double totalLightKWh = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchMonthlyUsageData(int loadId) async {
    setState(() {
      loading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse('http://124.43.136.185/GET_monthly_energy_usage.php'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        // Extract the last month
        List<dynamic> filteredData = jsonResponse
            .where((data) => data['load_id'] == loadId.toString())
            .toList();

        // Find the latest month
        filteredData.sort((a, b) => a['month'].compareTo(b['month']));
        final lastMonth = filteredData.isNotEmpty ? filteredData.last['month'] : null;

        if (lastMonth != null) {
          filteredData = filteredData.where((data) => data['month'] == lastMonth).toList();
        }

        // Calculate total kWh for the last month
        double totalKWh = 0;
        for (var data in filteredData) {
          totalKWh += double.parse(data['kWh']);
        }

        if (loadId == 1) {
          totalITLoadKWh = totalKWh;
        } else if (loadId == 2) {
          totalACLoadKWh = totalKWh;
        } else if (loadId == 3) {
          totalLightKWh = totalKWh;
        }

        setState(() {
          monthlyUsage = [
            MonthlyUsageData(
              loadType: getLoadType(loadId),
              totalKWh: totalKWh,
            ),
          ];
          loading = false;
        });
      } else {
        print('Failed to load monthly usage data: ${response.statusCode}');
        setState(() {
          loading = false;
          errorMessage = 'Failed to load monthly usage data: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error fetching monthly usage data: $e');
      setState(() {
        loading = false;
        errorMessage = 'Error fetching monthly usage data: $e';
      });
    }
  }

  String getLoadType(int loadId) {
    switch (loadId) {
      case 1:
        return 'IT Load';
      case 2:
        return 'AC Load';
      case 3:
        return 'Light';
      default:
        return 'Unknown Load';
    }
  }

  void showTotalKWh() {
    final totalKWh = totalITLoadKWh + totalACLoadKWh + totalLightKWh;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Total kWh'),
        content: Text('Total kWh for all loads: $totalKWh'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> exportToCSV() async {
    List<List<dynamic>> rows = [];

    // Add headers
    rows.add(['Load Type', 'Total kWh']);

    // Add data
    for (var data in monthlyUsage) {
      List<dynamic> row = [];
      row.add(data.loadType);
      row.add(data.totalKWh);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final directory = await getTemporaryDirectory();
    final filePath = p.join(directory.path, 'monthly_usage.csv');

    final File file = File(filePath);
    await file.writeAsString(csv);

    Share.shareFiles([filePath], text: 'Monthly Usage Data');
  }

  Future<Directory> getTemporaryDirectory() async {
    return Directory.systemTemp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Usage'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                fetchMonthlyUsageData(1);
              },
              child: Text('IT Load Monthly Usage'),
            ),
            ElevatedButton(
              onPressed: () {
                fetchMonthlyUsageData(2);
              },
              child: Text('AC Load Monthly Usage'),
            ),
            ElevatedButton(
              onPressed: () {
                fetchMonthlyUsageData(3);
              },
              child: Text('Light Monthly Usage'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchMonthlyUsageData(1).then((_) {
                  fetchMonthlyUsageData(2).then((_) {
                    fetchMonthlyUsageData(3).then((_) {
                      showTotalKWh();
                    });
                  });
                });
              },
              child: Text('Sum'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: exportToCSV,
              child: Text('Export'),
            ),
            SizedBox(height: 20),
            loading
                ? CircularProgressIndicator()
                : errorMessage.isNotEmpty
                ? Text(errorMessage)
                : monthlyUsage.isEmpty
                ? Text('No data available')
                : DataTable(
              columns: [
                DataColumn(label: Text('Load Type')),
                DataColumn(label: Text('Total kWh')),
              ],
              rows: monthlyUsage
                  .map((data) => DataRow(cells: [
                DataCell(Text(data.loadType)),
                DataCell(Text(data.totalKWh.toString())),
              ]))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthlyUsageData {
  final String loadType;
  final double totalKWh;

  MonthlyUsageData({required this.loadType, required this.totalKWh});
}
*/