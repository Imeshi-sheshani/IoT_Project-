/*import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LiveDataTab extends StatefulWidget {
  final dynamic location;

  LiveDataTab({required this.location});

  @override
  _LiveDataTabState createState() => _LiveDataTabState();
}

class _LiveDataTabState extends State<LiveDataTab> {
  late DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref().child('Location');
  }

  Future<Map<String, dynamic>> fetchLiveData() async {
    final region = widget.location['Region'];
    final station = widget.location['Station'];
    final building = widget.location['Building'];
    final floor = widget.location['Floor'];
    final room = widget.location['RoomName'];

    final path = 'Location/$region/$station/$building/$floor/$room';
    final snapshot = await databaseReference.child(path).get();

    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchLiveData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final liveData = snapshot.data!;

        return ListView(
          children: liveData.entries.map((entry) {
            final loadType = entry.key;
            final meters = entry.value as Map<String, dynamic>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: meters.entries.map((meterEntry) {
                final meterName = meterEntry.key;
                final meterData = meterEntry.value as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$loadType - $meterName',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text('VoltPhaseA: ${meterData['VoltPhaseA'] ?? 'N/A'} V'),
                        Text('VoltPhaseB: ${meterData['VoltPhaseB'] ?? 'N/A'} V'),
                        Text('VoltPhaseC: ${meterData['VoltPhaseC'] ?? 'N/A'} V'),
                        SizedBox(height: 8.0),
                        Text('CurPhaseA: ${meterData['CurPhaseA'] ?? 'N/A'} A'),
                        Text('CurPhaseB: ${meterData['CurPhaseB'] ?? 'N/A'} A'),
                        Text('CurPhaseC: ${meterData['CurPhaseC'] ?? 'N/A'} A'),
                        SizedBox(height: 8.0),
                        Text('FrePhaseA: ${meterData['FrePhaseA'] ?? 'N/A'} Hz'),
                        Text('FrePhaseB: ${meterData['FrePhaseB'] ?? 'N/A'} Hz'),
                        Text('FrePhaseC: ${meterData['FrePhaseC'] ?? 'N/A'} Hz'),
                        SizedBox(height: 8.0),
                        Text('Total kWh: ${meterData['Total_kWh'] ?? 'N/A'} kWh'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        );
      },
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LiveDataTab extends StatefulWidget {
  final dynamic location;

  LiveDataTab({required this.location});

  @override
  _LiveDataTabState createState() => _LiveDataTabState();
}

class _LiveDataTabState extends State<LiveDataTab> {
  late DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref().child('Location');
  }

  Future<Map<String, dynamic>> fetchLiveData() async {
    final region = widget.location['Region'];
    final station = widget.location['Station'];
    final building = widget.location['Building'];
    final floor = widget.location['Floor'];
    final room = widget.location['RoomName'];

    final path = '$region/$station/$building/$floor/$room';
    final snapshot = await databaseReference.child(path).get();

    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchLiveData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final liveData = snapshot.data!;

        return ListView(
          children: liveData.entries.map((entry) {
            final loadType = entry.key;
            final meters = entry.value as Map<String, dynamic>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: meters.entries.map((meterEntry) {
                final meterName = meterEntry.key;
                final meterData = meterEntry.value as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$loadType - $meterName',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text('VoltPhaseA: ${meterData['VoltPhaseA'] ?? 'N/A'} V'),
                        Text('VoltPhaseB: ${meterData['VoltPhaseB'] ?? 'N/A'} V'),
                        Text('VoltPhaseC: ${meterData['VoltPhaseC'] ?? 'N/A'} V'),
                        SizedBox(height: 8.0),
                        Text('CurPhaseA: ${meterData['CurPhaseA'] ?? 'N/A'} A'),
                        Text('CurPhaseB: ${meterData['CurPhaseB'] ?? 'N/A'} A'),
                        Text('CurPhaseC: ${meterData['CurPhaseC'] ?? 'N/A'} A'),
                        SizedBox(height: 8.0),
                        Text('FrePhaseA: ${meterData['FrePhaseA'] ?? 'N/A'} Hz'),
                        Text('FrePhaseB: ${meterData['FrePhaseB'] ?? 'N/A'} Hz'),
                        Text('FrePhaseC: ${meterData['FrePhaseC'] ?? 'N/A'} Hz'),
                        SizedBox(height: 8.0),
                        Text('Total kWh: ${meterData['Total_kWh'] ?? 'N/A'} kWh'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        );
      },
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MeterDetailsPage extends StatefulWidget {
  final Map<String, dynamic> location;

  MeterDetailsPage({required this.location});

  @override
  _MeterDetailsPageState createState() => _MeterDetailsPageState();
}

class _MeterDetailsPageState extends State<MeterDetailsPage> {
  late DatabaseReference _databaseReference;
  Map<String, dynamic>? meterData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('Region');
    fetchData();
  }

  Future<void> fetchData() async {
    final region = widget.location['Region'];
    final station = widget.location['Station'];
    final building = widget.location['Building'];
    final floor = widget.location['Floor'];
    final room = widget.location['RoomName'];

    final data = await _databaseReference
        .child('Region')
        .child(region)
        .child('Station')
        .child(station)
        .child('Building')
        .child(building)
        .child('Floor')
        .child(floor)
        .child('Room')
        .child(room)
        .once();

    setState(() {
      meterData = data.value as Map<String, dynamic>?;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meter Details'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Live Data'),
              Tab(text: 'Monthly Usage'),
              Tab(text: 'Usage'),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
          children: [
            LiveDataTab(meterData: meterData),
            MonthlyUsageTab(),
            UsageTab(),
          ],
        ),
      ),
    );
  }
}

class LiveDataTab extends StatelessWidget {
  final Map<String, dynamic>? meterData;

  LiveDataTab({this.meterData});

  @override
  Widget build(BuildContext context) {
    if (meterData == null) {
      return Center(child: Text('No Data Available'));
    }

    return ListView(
      children: meterData!.entries.map((entry) {
        return Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${entry.key}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...entry.value.entries.map((subEntry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text('${subEntry.key}: ${subEntry.value}'),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class MonthlyUsageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Monthly Usage Data'));
  }
}

class UsageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Usage Data'));
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MeterDetailsPage extends StatefulWidget {
  final String location;

  MeterDetailsPage({required this.location});

  @override
  _MeterDetailsPageState createState() => _MeterDetailsPageState();
}

class _MeterDetailsPageState extends State<MeterDetailsPage> {
  DatabaseReference? _databaseReference;
  Map<String, dynamic>? meterData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('Region').child(widget.location);
    fetchData();
  }

  Future<void> fetchData() async {
    _databaseReference?.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          meterData = Map<String, dynamic>.from(snapshot.value as Map);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : meterData == null
          ? Center(
        child: Text('No data available.'),
      )
          : ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildMeterCard('AC Load', meterData!['AC Load']),
          buildMeterCard('IT Load', meterData!['IT Load']),
          buildMeterCard('Light Load', meterData!['Light Load']),
          buildTotalKWhCard('Total kWh', meterData!['Total kWh']),
        ],
      ),
    );
  }

  Widget buildMeterCard(String title, Map<String, dynamic>? data) {
    if (data == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Current Phase A: ${data['CurPhaseA']}'),
            Text('Current Phase B: ${data['CurPhaseB']}'),
            Text('Current Phase C: ${data['CurPhaseC']}'),
            Text('Frequency Phase A: ${data['FrePhaseA']}'),
            Text('Frequency Phase B: ${data['FrePhaseB']}'),
            Text('Frequency Phase C: ${data['FrePhaseC']}'),
            Text('Voltage Phase A: ${data['VoltPhaseA']}'),
            Text('Voltage Phase B: ${data['VoltPhaseB']}'),
            Text('Voltage Phase C: ${data['VoltPhaseC']}'),
          ],
        ),
      ),
    );
  }

  Widget buildTotalKWhCard(String title, Map<String, dynamic>? data) {
    if (data == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Total kWh: ${data['Total_kWh']}'),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MeterDetailsPage extends StatefulWidget {
  final String location;
  final Map<String, dynamic> locationDetails;

  MeterDetailsPage({required this.location, required this.locationDetails});

  @override
  _MeterDetailsPageState createState() => _MeterDetailsPageState();
}

class _MeterDetailsPageState extends State<MeterDetailsPage> {
  DatabaseReference? _databaseReference;
  Map<String, dynamic>? meterData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('Region').child(widget.location);
    fetchData();
  }

  Future<void> fetchData() async {
    _databaseReference?.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          meterData = Map<String, dynamic>.from(snapshot.value as Map);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : meterData == null
          ? Center(
        child: Text('No data available.'),
      )
          : ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildMeterCard('AC Load', meterData!['AC Load']),
          buildMeterCard('IT Load', meterData!['IT LOad']),
          buildMeterCard('Light Load', meterData!['Light Load']),
          buildTotalKWhCard('Total kWh', meterData!['Total kWh']),
        ],
      ),
    );
  }

  Widget buildMeterCard(String title, Map<String, dynamic>? data) {
    if (data == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...data.entries.map((entry) {
              final meterId = entry.key;
              final meterDetails = entry.value as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meter ID: $meterId'),
                    Text('Current Phase A: ${meterDetails['CurPhaseA']}'),
                    Text('Current Phase B: ${meterDetails['CurPhaseB']}'),
                    Text('Current Phase C: ${meterDetails['CurPhaseC']}'),
                    Text('Frequency Phase A: ${meterDetails['FrePhaseA']}'),
                    Text('Frequency Phase B: ${meterDetails['FrePhaseB']}'),
                    Text('Frequency Phase C: ${meterDetails['FrePhaseC']}'),
                    Text('Voltage Phase A: ${meterDetails['VoltPhaseA']}'),
                    Text('Voltage Phase B: ${meterDetails['VoltPhaseB']}'),
                    Text('Voltage Phase C: ${meterDetails['VoltPhaseC']}'),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildTotalKWhCard(String title, Map<String, dynamic>? data) {
    if (data == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Total kWh: ${data['Total_kWh']}'),
          ],
        ),
      ),
    );
  }
}
*//*
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MeterDetailsPage extends StatefulWidget {
  final String location;
  final Map<String, dynamic> locationDetails;

  MeterDetailsPage({required this.location, required this.locationDetails});

  @override
  _MeterDetailsPageState createState() => _MeterDetailsPageState();
}

class _MeterDetailsPageState extends State<MeterDetailsPage> {
  DatabaseReference? _databaseReference;
  Map<String, dynamic>? meterData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('Region').child(widget.location);
    fetchData();
  }

  Future<void> fetchData() async {
    _databaseReference?.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          meterData = Map<String, dynamic>.from(snapshot.value as Map);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : meterData == null
          ? Center(
        child: Text('No data available.'),
      )
          : ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildMeterCard('AC Load', meterData!['AC Load']),
          buildMeterCard('IT Load', meterData!['IT Load']),
          buildMeterCard('Light Load', meterData!['Light Load']),
          buildTotalKWhCard('Total kWh', meterData!['Total kWh']),
        ],
      ),
    );
  }

  Widget buildMeterCard(String title, dynamic data) {
    if (data == null || data.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...data.entries.map((entry) {
              final meterId = entry.key;
              final meterDetails = entry.value as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meter ID: $meterId'),
                    Text('Voltage Phase A: ${meterDetails['VoltPhaseA']}'),
                    Text('Voltage Phase B: ${meterDetails['VoltPhaseB']}'),
                    Text('Voltage Phase C: ${meterDetails['VoltPhaseC']}'),
                    Text('Current Phase A: ${meterDetails['CurPhaseA']}'),
                    Text('Current Phase B: ${meterDetails['CurPhaseB']}'),
                    Text('Current Phase C: ${meterDetails['CurPhaseC']}'),
                    Text('Frequency Phase A: ${meterDetails['FrePhaseA']}'),
                    Text('Frequency Phase B: ${meterDetails['FrePhaseB']}'),
                    Text('Frequency Phase C: ${meterDetails['FrePhaseC']}'),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildTotalKWhCard(String title, Map<String, dynamic>? data) {
    if (data == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Total kWh: ${data['Total_kWh']}'),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MeterDetailsPage extends StatefulWidget {
  final String station;
  final String building;
  final String floor;
  final String room;

  MeterDetailsPage({
    required this.station,
    required this.building,
    required this.floor,
    required this.room, required region,
  });

  @override
  _MeterDetailsPageState createState() => _MeterDetailsPageState();
}

class _MeterDetailsPageState extends State<MeterDetailsPage> {
  DatabaseReference? _databaseReference;
  Map<String, dynamic>? meterData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref()
        .child('Region')
        .child(widget.station)
        .child('Building')
        .child(widget.building)
        .child('Floor')
        .child(widget.floor)
        .child('Room')
        .child(widget.room);

    fetchData();
  }

  Future<void> fetchData() async {
    _databaseReference?.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          meterData = Map<String, dynamic>.from(snapshot.value as Map);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : meterData == null
          ? Center(
        child: Text('No data available.'),
      )
          : ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildLoadCard('AC Load', meterData!['AC Load']),
          buildLoadCard('IT Load', meterData!['IT LOad']),
          buildLoadCard('Light Load', meterData!['Light Load']),
          buildTotalKWhCard('Total kWh', meterData!['Total kWh']),
        ],
      ),
    );
  }

  Widget buildLoadCard(String title, Map<String, dynamic>? data) {
    if (data == null || data.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...data.entries.map((entry) {
              final meterId = entry.key;
              final meterDetails = entry.value as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meter ID: $meterId'),
                    Text('Voltage Phase A: ${meterDetails['VoltPhaseA']}'),
                    Text('Voltage Phase B: ${meterDetails['VoltPhaseB']}'),
                    Text('Voltage Phase C: ${meterDetails['VoltPhaseC']}'),
                    Text('Current Phase A: ${meterDetails['CurPhaseA']}'),
                    Text('Current Phase B: ${meterDetails['CurPhaseB']}'),
                    Text('Current Phase C: ${meterDetails['CurPhaseC']}'),
                    Text('Frequency Phase A: ${meterDetails['FrePhaseA']}'),
                    Text('Frequency Phase B: ${meterDetails['FrePhaseB']}'),
                    Text('Frequency Phase C: ${meterDetails['FrePhaseC']}'),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildTotalKWhCard(String title, Map<String, dynamic>? data) {
    if (data == null || data.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('$title: No data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Total kWh: ${data['Total_kWh']}'),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'live_data_tab.dart'; // Import the live data tab
/*
class MeterDetailsPage extends StatelessWidget {
  final String Region;
  final String Station;
  final String Building;
  final String Floor;
  final String Room;

  MeterDetailsPage({
    required this.Region,
    required this.Station,
    required this.Building,
    required this.Floor,
    required this.Room,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meter Details'),
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
            LiveDataTab(
              region: Region,
              station: Station,
              building: Building,
              floor: Floor,
              room: Room,
            ),
            // Placeholder widgets for other tabs
            Center(child: Text('Monthly Usage')),
            Center(child: Text('Daily Usage')),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class MeterDetailsPage extends StatefulWidget {
  final String Region;
  final String Station;
  final String Building;
  final String Floor;
  final String Room;

  MeterDetailsPage({
    required this.Region,
    required this.Station,
    required this.Building,
    required this.Floor,
    required this.Room,
  });

  @override
  _MeterDetailsPageState createState() => _MeterDetailsPageState();
}

class _MeterDetailsPageState extends State<MeterDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.Region} - ${widget.Station}'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Live Data'),
            Tab(text: 'Monthly Usage'),
            Tab(text: 'Daily Usage'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LiveDataTab(region: widget.Region, station: widget.Station, building: widget.Building, floor: widget.Floor, room: widget.Room),
         // MonthlyUsageTab(),
         // DailyUsageTab(),
        ],
      ),
    );
  }
}
*/