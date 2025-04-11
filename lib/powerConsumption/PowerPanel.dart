/*
import 'package:flutter/material.dart';
import 'package:slt_power_prox_new/powerConsumption/EnergyReading.dart';
import 'package:slt_power_prox_new/powerConsumption/LiveData.dart';
import 'package:slt_power_prox_new/powerConsumption/MonthlyUsage.dart';


class PowerPanel extends StatefulWidget {
  PowerPanelState createState() =>PowerPanelState();
}

class PowerPanelState extends State<PowerPanel> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Power Panel"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),


              ElevatedButton(
                child: const Text("Live Data "),
                onPressed: () {
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveData(),
                  ));
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text("Energy Readings"),
                onPressed: () {
                   Navigator.push(
                    context,
                   MaterialPageRoute(
                  builder: (context) => Energyreading(),
                  ));
                },
              ),
              SizedBox(
                height: 15,
              ),
             /* ElevatedButton(
                child: const Text("Energy Usage"),
                onPressed: () {
                   Navigator.push(
                    context,
                   MaterialPageRoute(
                  builder: (context) => MonthlyUsagePage(location: location),
                  )
                        );
                },
              ),*/
              SizedBox(
                height: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }



  //RectifierDetailsScreen({required data}) {}
}
*/