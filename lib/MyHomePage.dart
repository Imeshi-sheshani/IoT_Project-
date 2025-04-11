//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*import 'package:slt_power_prox_new/BatteryDischargeTest/SelectLocation.dart';
import 'package:slt_power_prox_new/BatteryRequestViewNeww/RequestFilterScreen.dart';
import 'package:slt_power_prox_new/BatteryRequestViewPage/BatteryRequester.dart';
import 'package:slt_power_prox_new/BatteryRequestViewPage/BatteryRequesterViewPage.dart';
import 'package:slt_power_prox_new/BatteryRequester/BatteryRequester.dart';
import 'package:slt_power_prox_new/BatteryRequester/ReturnBatteryRequester.dart';
import 'package:slt_power_prox_new/FaultStatusUpdate/FaultStatusUpdate.dart';
import 'package:slt_power_prox_new/FaultStatusUpdate/GeneratorFault.dart';
import 'package:slt_power_prox_new/InstructionPage/safetyInstructions.dart';
import 'package:slt_power_prox_new/QR/ScanDataCam.dart';
import 'package:slt_power_prox_new/QR/ScanDataCamNew.dart';
import 'package:slt_power_prox_new/ScanMe/ScanMe.dart';
import 'package:slt_power_prox_new/ServiceLog/ScanOrManual.dart';
import 'package:slt_power_prox_new/SubmitBatteryQuations/SubmitBatteryQuations.dart';
import 'package:slt_power_prox_new/ViewGenUnits.dart';
//import 'package:slt_power_prox_new/test.dart';
//import 'package:slt_power_prox_new/ups.dart';
import 'AddModules.dart';
import 'DisplayContent.dart';
import 'NewUps.dart';
import 'Rec1.dart';
import 'Repair.dart';
import 'ServiceLog1.dart';
import 'NewRec.dart';
import 'ServiceLogDropDown.dart';
import 'View/ViewPage.dart';
import 'ViewRectifierDetails.dart';
import 'ups.dart';
import 'SerialNumberPage.dart';

 */
import 'package:slt_power_prox_new/powerConsumption/SelectStation.dart';

class MyHomePage extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var upsUnitData = {
      'ID': 1,
      'Region': 'North',

      // ... other data properties
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("SLT PowerProx"),
        backgroundColor: Colors.limeAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              // ElevatedButton(
              //   child: const Text("Add Rectifier Modules"),
              // onPressed: () {
              // Navigator.push(
              //   context,
              // MaterialPageRoute(
              //builder: (context) => NewRec(),
              //));
              // },
              //),
              //SizedBox(
              //height: 15,
              //),

              ElevatedButton(
                child: const Text("Power Spending "),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewRecSelector(),
                      ));
                },
              ),
              SizedBox(
                height: 15,
              ),
              /* ElevatedButton(
                   onPressed: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => ServiceLogDropDown(),
                         ));
                   },
                   child: Text("Service Log New")),
               SizedBox(
                 height: 15,
               ),

                 ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                                  context,
                                MaterialPageRoute(
                                  builder: (context) => SafetyInstructions(),
                                ));
                         },
                  child: const Text("Safety Instruction")),

               SizedBox(
                  height: 15,
                ),

                  ElevatedButton(
                       onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => SelectLocation(),
                                 ));
                          },
                  child: const Text("Bi Annual Discharge Test")),

              SizedBox(
                  height: 15,
                ),

ElevatedButton(
                  onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubmitBatteryQuations(),
                                ));
                          },
                  child: const Text("Submit Battery Quotation")),

              SizedBox(
                  height: 15,
                ),

              ElevatedButton(
                  onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScanMe(),
                                ));
                          },
                  child: const Text("Scan Me")),

              SizedBox(
                  height: 15,
              ),
               ElevatedButton(
                   onPressed: () {
                      Navigator.push(
                         context,
                      MaterialPageRoute(
                                  builder: (context) => BatteryRequesterViewPage(),
                                ));
                         },
                  child: const Text("Battery Request View")),

                SizedBox(
                  height: 15,
                ),

               ElevatedButton(
                   onPressed: () {
                           Navigator.push(
                                context,
                       MaterialPageRoute(
                                    builder: (context) => RequestFilterScreen(),
                               ));
                     },
                    child: const Text("Battery Request View New")),*/
            ],
          ),
        ),
      ),
    );
  }

  RectifierDetailsScreen({required data}) {}
}
