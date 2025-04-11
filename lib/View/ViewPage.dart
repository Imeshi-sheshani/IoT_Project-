import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slt_power_prox_new/View/ViewBattery.dart';
import 'package:slt_power_prox_new/View/ViewSPDUnit.dart';
import 'package:http/http.dart' as http;

import 'ViewRectifierUnit.dart';
import 'ViewUPSUnit.dart';

class ViewPage extends StatelessWidget {
  // Map<String, dynamic> rectifierData = {
  //   'RecID': '12345',
  //   'Region': 'HQ',
  //   'RTOM': 'Site A',
  //   'Station': 'Station X',
  //   'Brand': 'ZTE',
  //   'Model': 'XYZ123',
  //   'FrameCap': '200A',
  //   'FrameCapType': 'kW',
  //   'Type': 'Type A',
  //   'Serial': 'SR56789',
  //   'InstalledDate': '2023-01-15',
  //   'PWModModel': 'PowerModel1',
  //   'AmpRating': '500',
  //   'PWModsAvail': '5',
  //   'PWModsUsed': '3',
  //   'CtrModModel': 'ControlModel1',
  //   'CtrModsAvail': '4',
  //   'CtrModsUsed': '2',
  //
  //   // Add more fields if needed
  // };
  //
  // Map<String, dynamic> upsData = {
  //   'upsID': '5',
  //   'Region': 'HQ',
  //   'Station': 'Matara',
  //   'Brand': 'APC',
  //   'UPSBrandOther': null,
  //   'Model': 'Model 1',
  //   'UPSCap': '500A',
  //   'Type': 'Type A',
  //   'Serial': '1234567',
  //   'InstalledDate': '2023-01-15',
  //   'PWModModel': 'power model 1',
  //   'PWModsAvail': '8',
  //   'PWModsUsed': '5',
  //   'CtrModModel': 'Control model 1',
  //   'CtrModsAvail': '1',
  //   'CtrModsUsed': '1'
  // };
  //
  // Map<String, dynamic> spdData = {
  //   'SPDid': '1',
  //   'province': '',
  //   'Rtom_name': '',
  //   'station': '',
  //   'SPDLoc': '',
  //   'DCFlag': '1',
  //   'poles': '',
  //   'SPDType': '',
  //   'SPD_Manu': '',
  //   'model_SPD': '',
  //   'status': '',
  //   'PercentageR': '',
  //   'PercentageY': '',
  //   'PercentageB': '',
  //   'nom_volt': '',
  //   'UcDCVolt': '',
  //   'UpDCVolt': '',
  //   'Nom_Dis8_20': '',
  //   'Nom_Dis10_350': '',
  //   'modular': '',
  //   'phase': '',
  //   'UcLiveVolt': '',
  //   'UcNeutralVolt': '',
  //   'UcLiveMode': '',
  //   'UpLiveVolt': '',
  //   'UpNeutralVolt': '',
  //   'dischargeType': '',
  //   'L8to20Nom': '',
  //   'N8to20NomD': '',
  //   'L10to350ImpD': '',
  //   'N10to350ImpD': '',
  //   'mcbRating': '',
  //   'responseTime': '',
  //   'installDt': '',
  //   'warrentyDt': '',
  //   'Notes': '',
  //   'Submitter': '',
  //   'LastUpdated': ''
  // };

  bool _dataLoaded = false;
  bool _isLoading = true;
  List<dynamic> _dataList = [];
  bool _matchFound = false;
  Map<String, dynamic> _matchedStation = {};
  String systemID = '88';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Modules"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewRectifierUnit(
                            station: 'R: HQ_1',
                          ),
                        ));
                  },
                  child: Text("View Rectifier")),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewUPSUnit(station: 'U:HQ_9'),
                        ));
                  },
                  child: Text("View UPS")),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewSPDUnit(station: 'dummy'),
                        ));
                  },
                  child: Text("View SPD")),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewBatteryUnit(
                            SystemID: "97",
                          ),
                        ));
                  },
                  child: Text("View Battery")),
            ],
          ),
        ),
      ),
    );
  }
}
