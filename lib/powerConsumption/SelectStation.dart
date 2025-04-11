
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:slt_power_prox_new/powerConsumption/MonthlyUsage.dart';
import 'package:slt_power_prox_new/powerConsumption/DailyUsage.dart';
import 'package:slt_power_prox_new/powerConsumption/LiveData.dart';

class ViewRecSelector extends StatefulWidget {
  @override
  _ViewRecSelectorState createState() => _ViewRecSelectorState();
}

class _ViewRecSelectorState extends State<ViewRecSelector> {
  var regions = [
    'ALL', 'CPN', 'CPS', 'EPN', 'EPS', 'EPN–TC', 'HQ', 'NCP', 'NPN', 'NPS',
    'NWPE', 'NWPW', 'PITI', 'SAB', 'SMW6', 'SPE', 'SPW', 'WEL', 'WPC',
    'WPE', 'WPN', 'WPNE', 'WPS', 'WPSE', 'WPSW', 'UVA'
  ];

  String selectedRegion = 'ALL';
  List<dynamic> locations = [];
  bool isLoading = true;

  Future<void> fetchLocations() async {
    final url = "https://powerprox.sltidc.lk/GET_Location.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        locations = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: selectedRegion,
              decoration: InputDecoration(
                labelText: 'Select Region',
              ),
              onChanged: (value) {
                setState(() {
                  selectedRegion = value!;
                });
              },
              items: regions.map((region) {
                return DropdownMenuItem<String>(
                  value: region,
                  child: Text(region),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView(
              children: locations
                  .where((loc) => selectedRegion == 'ALL' || loc['Region'] == selectedRegion)
                  .map((loc) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MeterDetailsPage(
                          locationId: loc['LocationID'],  // Pass LocationID here
                          region: loc['Region'],
                          station: loc['Station'],
                          building: loc['Building'],
                          floor: loc['Floor'],
                          room: loc['RoomName'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Station: ${loc['Station']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text('Building: ${loc['Building']}'),
                          SizedBox(height: 5),
                          Text('Floor: ${loc['Floor']}'),
                          SizedBox(height: 5),
                          Text('Room: ${loc['RoomName']}'),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MeterDetailsPage extends StatelessWidget {
  final String locationId;  // Add LocationID here
  final String region;
  final String station;
  final String building;
  final String floor;
  final String room;

  MeterDetailsPage({
    required this.locationId,  // Include LocationID in the constructor
    required this.region,
    required this.station,
    required this.building,
    required this.floor,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meter Details'),
          backgroundColor: Colors.blueGrey,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Live Data'),
              Tab(text: 'Monthly Usage'),
              Tab(text: 'Daily Usage'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LiveDataTab(region: region, station: station, building: building, floor: floor, room: room),
            MonthlyUsageScreen(locationId: locationId),
            // Pass LocationID here for Monthly Usage

            DailyUsageScreen(locationId: locationId),
            // Center(child: Text('Daily Usage Data')),  // Placeholder for Daily Usage
          ],
        ),
      ),
    );
  }
}
/*
class LiveDataTab extends StatefulWidget {
  final String region;
  final String station;
  final String building;
  final String floor;
  final String room;

  LiveDataTab({
    required this.region,
    required this.station,
    required this.building,
    required this.floor,
    required this.room,
  });

  @override
  _LiveDataTabState createState() => _LiveDataTabState();
}

class _LiveDataTabState extends State<LiveDataTab> {
  Map<String, dynamic>? roomData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref();
      final DataSnapshot snapshot = await ref
          .child('Region')
          .child(widget.region)
          .child('Station')
          .child(widget.station)
          .child('Building')
          .child(widget.building)
          .child('Floor')
          .child(widget.floor)
          .child('Room')
          .child(widget.room)
          .get();

      if (snapshot.exists) {
        print("Data received: ${snapshot.value}");
        final data = snapshot.value as Map<Object?, Object?>;
        setState(() {
          roomData = _convertToMap<String, dynamic>(data);
          isLoading = false;
        });
      } else {
        print("No data available at path.");
        setState(() {
          roomData = null;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        roomData = null;
        isLoading = false;
      });
    }
  }

  Map<String, dynamic> _convertToMap<K, V>(Map<Object?, Object?> data) {
    final result = <String, dynamic>{};
    data.forEach((key, value) {
      if (value is Map) {
        result[key.toString()] = _convertToMap<String, dynamic>(value as Map<Object?, Object?>);
      } else {
        result[key.toString()] = value;
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (roomData == null) {
      return Center(child: Text('No data available for this location.'));
    }

    return ListView(
      children: [
        for (var loadType in roomData!.keys)
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(loadType, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  if (roomData![loadType] is Map)
                    ...(roomData![loadType] as Map<String, dynamic>).entries.map((entry) {
                      final meterId = entry.key;
                      final meterData = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Meter ID: $meterId', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          if (meterData is Map) ...[
                            Text('Current Phase A: ${meterData['CurPhaseA']}'),
                            Text('Current Phase B: ${meterData['CurPhaseB']}'),
                            Text('Current Phase C: ${meterData['CurPhaseC']}'),
                            Text('Frequency Phase A: ${meterData['FrePhaseA']}'),
                            Text('Frequency Phase B: ${meterData['FrePhaseB']}'),
                            Text('Frequency Phase C: ${meterData['FrePhaseC']}'),
                            Text('Voltage Phase A: ${meterData['VoltPhaseA']}'),
                            Text('Voltage Phase B: ${meterData['VoltPhaseB']}'),
                            Text('Voltage Phase C: ${meterData['VoltPhaseC']}'),
                          ] else if (meterData is int) ...[
                            Text('Total kWh: $meterData'),
                          ],
                          SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  if (loadType == 'Total kWh' && roomData![loadType] is Map)
                    Text('Total kWh: ${roomData![loadType]['Total_kWh']}'),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
*/
