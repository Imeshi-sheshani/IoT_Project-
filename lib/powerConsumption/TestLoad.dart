import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadDetailPage extends StatefulWidget {
  final String loadType;
  final int loadId;

  LoadDetailPage({required this.loadType, required this.loadId});

  @override
  _LoadDetailPageState createState() => _LoadDetailPageState();
}

class _LoadDetailPageState extends State<LoadDetailPage> {
  List<LoadData> loadData = [];
  bool loading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchDataForLoadType(widget.loadId);
  }

  Future<void> fetchDataForLoadType(int loadId) async {
    setState(() {
      loading = true;
      errorMessage = '';
    });

    try {
      print('Making API request...');
      final response = await http.get(Uri.parse('http://124.43.136.185/GET_daily_energy_usage.php'));
      print('API request completed with status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        // Debug: Print the entire response to the console
        print('API Response: ${response.body}');

        // Filter data based on load_id
        final List<dynamic> filteredData = jsonResponse.where((data) => data['load_id'] == loadId.toString()).toList();

        // Debug: Print filtered data
        print('Filtered Data: $filteredData');

        setState(() {
          loadData = filteredData.map((data) => LoadData.fromJson(data)).toList();
          loading = false;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          loading = false;
          errorMessage = 'Failed to load data: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        loading = false;
        errorMessage = 'Error fetching data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.loadType} Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : loadData.isEmpty
          ? Center(child: Text('No data available'))
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('kWh')),
            DataColumn(label: Text('kVA')),
            DataColumn(label: Text('MeterID')),
          ],
          rows: loadData.map((data) {
            return DataRow(cells: [
              DataCell(Text(data.date)),
              DataCell(Text(data.kWh.toString())),
              DataCell(Text(data.kVA.toString())),
              DataCell(Text(data.energy_meter_id.toString())),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

class LoadData {
  final String date;
  final double kWh;
  final double kVA;
  final int energy_meter_id;

  LoadData({
    required this.date,
    required this.kWh,
    required this.kVA,
    required this.energy_meter_id,
  });

  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(
      date: json['date'],
      kWh: double.parse(json['kWh']),
      kVA: double.parse(json['kVA']),
      energy_meter_id: int.parse(json['energy_meter_id']),
    );
  }
}
