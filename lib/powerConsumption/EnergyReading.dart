
import 'package:flutter/material.dart';
import 'package:slt_power_prox_new/powerConsumption/TestLoad.dart';  // Import the LoadDetailPage

/*Add three buttons related to the three types and when they
are clicked, the corresponding data will be obtained from the sql
database.

Here, data filtering is done according to the load_id in the
database .

That filtering part is in TestLoad.dart file
 */


class Energyreading extends StatefulWidget {
  @override
  EnergyreadingState createState() => EnergyreadingState();
}
//
class EnergyreadingState extends State<Energyreading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Energy Readings"),
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
                child: const Text("IT Load"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadDetailPage(loadType: 'IT Load', loadId: 1),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text("AC Load"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadDetailPage(loadType: 'AC Load', loadId: 2),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text("Light & other Load"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadDetailPage(loadType: 'Light & Other Load', loadId: 3),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
