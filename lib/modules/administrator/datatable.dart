import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:our_project_1/shared/components/components.dart';

class User_Data extends StatefulWidget {
  static const String routeName = "User_data";
  const User_Data({super.key});

  @override
  State<User_Data> createState() => _User_DataState();
}

class _User_DataState extends State<User_Data> {
  var value = phone_User.value;

  final Future<FirebaseApp> fApp = Firebase.initializeApp();
  String speedvalue = '0';
  String idvalue = '0';
  String distancevalue = '0';
  String drowisnessvalue = '0';
  String ratevalue = '0';

  DatabaseReference testref = FirebaseDatabase.instance.ref('violation');
  @override
  Widget build(BuildContext context) {
    testref.onValue.listen(
      (event) {
        setState(() {
          speedvalue = event.snapshot.child('Speed').value.toString();
          idvalue = event.snapshot.child('Id').value.toString();
          distancevalue = event.snapshot.child('Distance').value.toString();
          drowisnessvalue = event.snapshot.child('Drowisness').value.toString();
          ratevalue = event.snapshot.child('Rate').value.toString();
        });
      },
    );
    return Scaffold(
        backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
        appBar: AppBar(
          iconTheme: const IconThemeData(size: 40, color: Colors.white),
          backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
          title: const Text(
            'User\'s data',
            style: TextStyle(
              fontSize: 35.0,
            ),
          ),
        ),
        body: FutureBuilder(
          future: fApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("something wrong");
            } else if (snapshot.hasData) {
              return content();
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  Widget content() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          value.text,
          style: const TextStyle(
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        DataTable(
          columnSpacing: 12,
          decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(5.0))),
          border: TableBorder.all(color: Colors.white),
          columns: const <DataColumn>[
            DataColumn(
                label: Text(
              'Id',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            DataColumn(
                label: Text(
              'Speed',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            DataColumn(
                label: Text(
              'Distance',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            DataColumn(
                label: Text(
              'Drowisness',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            DataColumn(
                label: Text(
              'Rate',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
          ],
          rows: <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(
                Text(
                  idvalue,
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  speedvalue,
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  '$distancevalue m',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  '$drowisnessvalue time',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  '$ratevalue %',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
            ]),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        defaultButton(
          background: const Color(0xFF8E0C19),
          text: 'Reset',
          function: () async {
            await testref.set({
              'Speed': '0',
              'Distance': '0',
              'Rate': '100',
              'Id': 1,
              'Drowisness': '0',
            });
          },
        )
      ]),
    );
  }
}
