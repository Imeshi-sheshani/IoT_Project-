/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

/*Live data display will happen in this page.
The live data is obtained through firebase.
 */

class LiveData extends StatefulWidget {
  @override
  LiveDataState createState() => LiveDataState();
}

class LiveDataState extends State<LiveData> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('Meters');
  Map<String, dynamic> _data = {};
  String? _selectedMeter;

  @override
  void initState() {
    super.initState();
    _databaseRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _data = Map<String, dynamic>.from(data as Map);
        });
      }
    });
  }

  // Add table and display type wise live data

  Widget _buildTable(Map<String, dynamic> meterData) {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            TableCell(child: Center(child: Text('Category'))),
            TableCell(child: Center(child: Text('PhaseA'))),
            TableCell(child: Center(child: Text('PhaseB'))),
            TableCell(child: Center(child: Text('PhaseC'))),
          ],
        ),
        TableRow(
          children: [
            TableCell(child: Center(child: Text('Voltage'))),

            TableCell(child: Center(child: Text(meterData['VoltPhaseA'].toString()))),
            TableCell(child: Center(child: Text(meterData['VoltPhaseB'].toString()))),
            TableCell(child: Center(child: Text(meterData['VoltPhaseC'].toString()))),
          ],
        ),
        TableRow(
          children: [
            TableCell(child: Center(child: Text('Current'))),
            TableCell(child: Center(child: Text(meterData['CurPhaseA'].toString()))),
            TableCell(child: Center(child: Text(meterData['CurPhaseB'].toString()))),
            TableCell(child: Center(child: Text(meterData['CurPhaseC'].toString()))),
          ],
        ),
        TableRow(
          children: [
            TableCell(child: Center(child: Text('Frequency'))),
            //TableCell(child: Center(child: Text(meterData['FrePhaseA'].toString()))),
            //TableCell(child: Center(child: Text(meterData['FrePhaseB'].toString()))),
           // TableCell(child: Center(child: Text(meterData['FrePhaseC'].toString()))),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Data'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        // Add dropdown menu and select meter
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              hint: Text('Select Meter'),
              value: _selectedMeter,
              items: _data.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMeter = value;
                });
              },
            ),
          ),
          // Select the meter and display table
          _selectedMeter == null
              ? Center(child: Text('Display Table'))
              : Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Meter: $_selectedMeter',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildTable(Map<String, dynamic>.from(_data[_selectedMeter] as Map)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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

                            //Text('Frequency Phase B: ${meterData['FrePhaseB']}'),
                           // Text('Frequency Phase C: ${meterData['FrePhaseC']}'),
                            Text('Voltage Phase A: ${meterData['VoltPhaseA']}'),
                            Text('Voltage Phase B: ${meterData['VoltPhaseB']}'),
                            Text('Voltage Phase C: ${meterData['VoltPhaseC']}'),
                            Text('Frequency Phase A: ${meterData['FrePhaseA']}'),
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
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LiveDataTab extends StatefulWidget {
  final String region;
  final String station;
  final String building;
  final String floor;
  final String room;

  const LiveDataTab({
    required this.region,
    required this.station,
    required this.building,
    required this.floor,
    required this.room,
    Key? key,
  }) : super(key: key);

  @override
  _LiveDataTabState createState() => _LiveDataTabState();
}

class _LiveDataTabState extends State<LiveDataTab> {
  Map<String, dynamic>? roomData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

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
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          roomData = data;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No data available for this location.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data. Please try again later.';
        isLoading = false;
      });
    }
  }

  Widget buildDataTable(Map<String, dynamic> meterData) {
    final rows = meterData.entries.map((entry) {
      return DataRow(cells: [
        DataCell(Text(entry.key)),
        DataCell(Text(entry.value.toString())),
      ]);
    }).toList();

    return DataTable(
      columns: const [
        DataColumn(label: Text('Parameter')),
        DataColumn(label: Text('Value')),
      ],
      rows: rows,
      headingRowColor:
      WidgetStateColor.resolveWith((states) => Colors.blueGrey.shade100),
      columnSpacing: 20,
      dividerThickness: 1,
    );
  }

  Widget buildMeterData(String meterId, dynamic meterData) {
    if (meterData is Map) {
      // If meterData is a Map, show it as a table
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          color: Colors.grey.shade50,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meter ID: $meterId',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                buildDataTable(Map<String, dynamic>.from(meterData)),
              ],
            ),
          ),
        ),
      );
    } else if (meterData is int) {
      // If meterData is an int, display it as simple text
      return ListTile(
        title: Text('Meter ID: $meterId'),
        subtitle: Text('Total kWh: $meterData'),
      );
    } else {
      // If meterData is of another unexpected type, handle it gracefully
      return ListTile(
        title: Text('Meter ID: $meterId'),
        subtitle: Text('Unsupported data type: ${meterData.runtimeType}'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: fetchData,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage != null
            ? Center(child: Text(errorMessage!))
            : ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: roomData!.keys.length,
          itemBuilder: (context, index) {
            final loadType = roomData!.keys.elementAt(index);
            final loadData = roomData![loadType];

            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ExpansionTile(
                leading: Icon(Icons.electrical_services),
                title: Text(
                  loadType,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: loadData is Map
                    ? loadData.entries
                    .map<Widget>((entry) =>
                    buildMeterData(entry.key, entry.value))
                    .toList()
                    : [
                  ListTile(
                    title: Text(loadType),
                    subtitle: Text(loadData.toString()),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
